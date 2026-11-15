// Runs production policy and Apple bytecode on synthetic user-process objects.
// No kernel memory, GPU service, register, display mode or EFI access.
#include "tg_cache_core.hpp"
#include "tg_cache_layout.hpp"
#include <sys/mman.h>
#include <cassert>
#include <cstring>
#include <fstream>
#include <iterator>
#include <iostream>
#include <vector>
#include <array>

using Bytes=std::vector<uint8_t>;
using Native=int (*)(void *);
template<class T> void put(Bytes &b,size_t off,T value) {assert(off+sizeof(T)<=b.size());std::memcpy(b.data()+off,&value,sizeof(value));}
template<class T> T get(const Bytes &b,size_t off) {T value {};assert(off+sizeof(T)<=b.size());std::memcpy(&value,b.data()+off,sizeof(value));return value;}
struct Reader {
    std::vector<const Bytes *> ranges;
    bool operator()(uintptr_t p,void *out,size_t n) const {
        if(!n || n>512 || p>UINTPTR_MAX-n) return false;
        for(auto b:ranges) {
            auto start=reinterpret_cast<uintptr_t>(b->data());
            if(p>=start && p-start<=b->size() && n<=b->size()-(p-start)) {std::memcpy(out,reinterpret_cast<void *>(p),n);return true;}
        }
        return false;
    }
};
static unsigned nativeQueries;
static void *fakeDal(void *helper) {void *dal {};std::memcpy(&dal,static_cast<uint8_t *>(helper)+0x48,sizeof(dal));return dal;}
static int fakeQuery(void *dal,uint32_t fb,uint8_t stream) {
    assert(fb<3 && stream==0);++nativeQueries;
    int result {};std::memcpy(&result,static_cast<uint8_t *>(dal)+0x680+fb*4,sizeof(result));return result;
}
struct Fixture {
    Bytes controller=Bytes(0x7B00),helper=Bytes(0x180),helperTable=Bytes(0x180),dal=Bytes(0x700),table=Bytes(0x180);
    Bytes core=Bytes(0x500),owner=Bytes(0x40),handle=Bytes(0x40),stream=Bytes(0x400),context=Bytes(0x20),dc=Bytes(0x240);
    Bytes nextHandle=Bytes(0x40),nextStream=Bytes(0x400),nextDC=Bytes(0x240);
    A51Tg::State state {};
    uint64_t registryId=42;
    uintptr_t module=reinterpret_cast<uintptr_t>(fakeQuery)-0x6BC98;
    unsigned writes=0;
    Fixture(int tg) {
        put<uint8_t>(controller,0xBD,2);
        put<void *>(controller,0x7938,helper.data());put<void *>(helper,0,helperTable.data());
        put<uintptr_t>(helperTable,0x120,reinterpret_cast<uintptr_t>(fakeDal));
        put<void *>(helper,0x48,dal.data());put<void *>(dal,0,table.data());put<uintptr_t>(table,0xD8,reinterpret_cast<uintptr_t>(fakeQuery));
        put<void *>(dal,0x648,core.data());put<uint32_t>(core,0x1C,3);put<void *>(dal,0x470,owner.data());
        put<void *>(owner,0x10,handle.data());put<void *>(handle,0x20,stream.data());put<void *>(stream,0x3C0,context.data());
        put<void *>(context,0,core.data());put<void *>(core,0x3E0,dc.data());
        put<uint8_t>(dc,0x1E0,2);put<void *>(dc,0,stream.data());put<int32_t>(dc,0x30,tg);
        put<int32_t>(dal,0x680,tg);put<int32_t>(dal,0x684,1);
        put<uint8_t>(controller,0x1B8+0x719,1);put<uint32_t>(controller,0x1B8+0xD0,1);put<int32_t>(controller,0x294,-1);
        size_t external=0x1B8+0x7C8;
        put<uint32_t>(controller,external,1);put<uint8_t>(controller,external+0x718,1);put<uint8_t>(controller,external+0x719,1);
        put<uint32_t>(controller,external+0xD0,1);put<int32_t>(controller,external+0xDC,-1);
    }
    Reader reader() const {return {{&controller,&helper,&helperTable,&dal,&table,&core,&owner,&handle,&stream,&context,&dc,&nextHandle,&nextStream,&nextDC}};}
    A51Tg::Key key() const {return {reinterpret_cast<uintptr_t>(controller.data()),registryId};}
    A51Tg::View view() const {return A51Tg::inspect(reader(),key().controller,module);}
    auto cas() {
        return [this](uintptr_t p,int32_t expected,int32_t desired) {
            assert(p==key().controller+A51Tg::CacheField);
            auto address=reinterpret_cast<int32_t *>(p);
            bool success=__atomic_compare_exchange_n(address,&expected,desired,false,__ATOMIC_SEQ_CST,__ATOMIC_SEQ_CST);
            if(success) ++writes;return success;
        };
    }
    A51Tg::Result cache(Native native,bool fixed=true) {
        auto ticket=state.beginCache();assert(native(controller.data())==0);
        auto a=view(),b=view();return state.finishCache(key(),ticket,fixed,a,b,cas());
    }
    int32_t cached() const {return get<int32_t>(controller,A51Tg::CacheField);}
    void newMode(int tg) {
        put<void *>(owner,0x10,nextHandle.data());put<void *>(nextHandle,0x20,nextStream.data());
        put<void *>(nextStream,0x3C0,context.data());put<void *>(core,0x3E0,nextDC.data());
        put<uint8_t>(nextDC,0x1E0,1);put<void *>(nextDC,0,nextStream.data());put<int32_t>(nextDC,0x30,tg);
    }
};
struct Executable {
    void *memory {};
    Native original {},shortTrampoline {};
    Executable(const Bytes &image,size_t from,size_t until,size_t stolen) {
        assert(from<until && until<=image.size() && until-from<512);
        memory=mmap(nullptr,4096,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON,-1,0);assert(memory!=MAP_FAILED);
        auto p=static_cast<uint8_t *>(memory);std::memcpy(p,image.data()+from,until-from);
        // Exactly the 6/7-byte PIC instruction that Lilu's forced short route copies.
        std::memcpy(p+512,p,stolen);uint8_t jump[14]={0xFF,0x25,0,0,0,0};
        uintptr_t destination=reinterpret_cast<uintptr_t>(p+stolen);std::memcpy(jump+6,&destination,8);std::memcpy(p+512+stolen,jump,14);
        assert(mprotect(memory,4096,PROT_READ|PROT_EXEC)==0);
        original=reinterpret_cast<Native>(p);shortTrampoline=reinterpret_cast<Native>(p+512);
    }
    ~Executable() {munmap(memory,4096);}
};
int main(int argc,char **argv) {
    assert(argc==2);std::ifstream file(argv[1],std::ios::binary);Bytes image((std::istreambuf_iterator<char>(file)),{});assert(!image.empty());
    Reader imageReader {{&image}};auto base=reinterpret_cast<uintptr_t>(image.data());
    assert(A51Tg::imageUUID(imageReader,base,image.size(),A51TgLayout::DriverUUID));
    for(auto &anchor:A51TgLayout::Anchors) assert(!std::memcmp(image.data()+anchor.offset,anchor.bytes,sizeof(anchor.bytes)));
    std::array<uint8_t,16> bad {};assert(!A51Tg::imageUUID(imageReader,base,image.size(),bad.data()));
    auto saved=get<uint32_t>(image,36);put<uint32_t>(image,36,0);assert(!A51Tg::imageUUID(imageReader,base,image.size(),A51TgLayout::DriverUUID));put(image,36,saved);
    assert(!A51Tg::imageUUID(imageReader,UINTPTR_MAX-8,image.size(),A51TgLayout::DriverUUID));
    assert(A51Tg::fitsRel32(0x100000000ULL,0x180000004ULL));assert(!A51Tg::fitsRel32(0x100000000ULL,0x180000005ULL));
    assert(A51Tg::fitsRel32(0x100000000ULL,0x80000005ULL));assert(!A51Tg::fitsRel32(0x100000000ULL,0x80000004ULL));assert(!A51Tg::fitsRel32(UINTPTR_MAX,0));
    Executable cache(image,0x4CE20,0x4CF04,6),invalidate(image,0x4CF04,0x4CF7E,7);
    for(auto nativeCache:{cache.original,cache.shortTrampoline}) {
        for(int tg=0;tg<6;++tg) {
            Fixture f(tg);nativeQueries=0;
            assert(nativeCache(f.controller.data())==0 && f.cached()==-1 && nativeQueries==1);
            auto baseline=f.controller;
            assert(f.cache(nativeCache)==A51Tg::Result::Recovered && f.cached()==tg);
            put<int32_t>(baseline,A51Tg::CacheField,tg);assert(baseline==f.controller); // only FB0 TG changed
            assert(f.cache(nativeCache)==A51Tg::Result::Unchanged);
            int next=(tg+2)%6;put<int32_t>(f.dc,0x30,next);
            assert(f.cache(nativeCache)==A51Tg::Result::Refreshed && f.cached()==next);
            assert(f.state.beginInvalidate(f.key(),f.cas()) && f.cached()==-1);
            assert(invalidate.shortTrampoline(f.controller.data())==0);
            assert(get<int32_t>(f.controller,0x1B8+0x7C8+0xDC)==-1);f.state.endInvalidate();
            f.newMode((tg+1)%6);assert(f.cache(nativeCache)==A51Tg::Result::Recovered && f.cached()==(tg+1)%6);
        }
    }
    // Both native entry and forced-short trampoline preserve the zero-FB fast return.
    for(auto fn:{cache.original,cache.shortTrampoline,invalidate.original,invalidate.shortTrampoline}) {
        Fixture f(2);put<uint8_t>(f.controller,0xBD,0);assert(fn(f.controller.data())==0);
    }
    // A cache result computed before (even a completed) invalidation must not revive old metadata.
    {Fixture f(4);auto ticket=f.state.beginCache();auto a=f.view();f.state.beginInvalidate(f.key(),f.cas());f.state.endInvalidate();assert(f.state.finishCache(f.key(),ticket,true,a,a,f.cas())==A51Tg::Result::Stale && f.cached()==-1);}
    // Nested mode callbacks and older overlapping cache events are rejected.
    {Fixture f(5);f.state.beginInvalidate(f.key(),f.cas());f.state.beginInvalidate(f.key(),f.cas());f.state.endInvalidate();auto t=f.state.beginCache();auto a=f.view();assert(f.state.finishCache(f.key(),t,true,a,a,f.cas())==A51Tg::Result::Stale);f.state.endInvalidate();assert(f.cache(cache.original)==A51Tg::Result::Recovered);}
    {Fixture f(2);auto old=f.state.beginCache();auto latest=f.state.beginCache();auto a=f.view();assert(f.state.finishCache(f.key(),old,true,a,a,f.cas())==A51Tg::Result::Stale);assert(f.state.finishCache(f.key(),latest,true,a,a,f.cas())==A51Tg::Result::Recovered);}
    // Preserve a concurrent writer and abandon ownership after a replacement value.
    {Fixture f(2);auto t=f.state.beginCache();auto a=f.view();put<int32_t>(f.controller,A51Tg::CacheField,5);assert(f.state.finishCache(f.key(),t,true,a,a,f.cas())==A51Tg::Result::CompareFailed && f.cached()==5);}
    {Fixture f(3);assert(f.cache(cache.original)==A51Tg::Result::Recovered);put<int32_t>(f.controller,A51Tg::CacheField,4);assert(!f.state.beginInvalidate(f.key(),f.cas()) && f.cached()==4);f.state.endInvalidate();}
    // Returning to native connected ownership must not erase a valid value.
    {Fixture f(1);assert(f.cache(cache.original)==A51Tg::Result::Recovered);put<uint8_t>(f.controller,0x1B8+0x718,1);assert(f.cache(cache.original)==A51Tg::Result::NativeOwned && f.cached()==1 && !f.state.cache);}
    // A reused controller address with a new registry ID must not inherit ownership.
    {Fixture f(2);assert(f.cache(cache.original)==A51Tg::Result::Recovered);++f.registryId;unsigned writes=f.writes;assert(!f.state.beginInvalidate(f.key(),f.cas()) && f.cached()==2 && f.writes==writes);f.state.endInvalidate();}
    // Missing current stream / offline transition discards only the value we wrote.
    {Fixture f(3);assert(f.cache(cache.original)==A51Tg::Result::Recovered);put<uintptr_t>(f.owner,0x10,0);assert(f.cache(cache.original)==A51Tg::Result::Cleared && f.cached()==-1);}
    {Fixture f(3);assert(f.cache(cache.original)==A51Tg::Result::Recovered);put<uint8_t>(f.controller,0x1B8+0x719,0);assert(f.cache(cache.original)==A51Tg::Result::Cleared && f.cached()==-1);}
    for(int badTg:{-1,6,255}) {Fixture f(badTg);assert(f.cache(cache.original)==A51Tg::Result::Unavailable && f.cached()==-1 && f.writes==0);}
    {Fixture f(3);assert(f.cache(cache.original,false)==A51Tg::Result::Skipped && f.cached()==-1);}
    for(size_t offset:{size_t(0xD0),size_t(0xD8),size_t(0xEC)}) {Fixture f(3);put<uint32_t>(f.controller,0x1B8+offset,2);auto ticket=f.state.beginCache();auto a=f.view();auto result=f.state.finishCache(f.key(),ticket,true,a,a,f.cas());assert(result==A51Tg::Result::Skipped && f.writes==0);}
    {Fixture f(2);put<int32_t>(f.controller,A51Tg::CacheField,4);assert(f.cache(cache.original)==A51Tg::Result::NativeOwned && f.cached()==4 && f.writes==0);}
    {Fixture f(2);auto ticket=f.state.beginCache();auto a=f.view(),b=a;b.native=3;assert(f.state.finishCache(f.key(),ticket,true,a,b,f.cas())==A51Tg::Result::Unavailable && f.writes==0);}
    std::cout<<"PASS: production TG policy; all 6 synthetic TG IDs; current-stream replacement; cache/invalidate ordering; nested/stale callbacks; concurrent writers; registry-ID reuse; offline/missing/invalid guards; exact UUID and rel32 limits.\n";
    std::cout<<"PASS: actual Apple cache/invalidate bytecode and 6/7-byte short trampolines on synthetic objects, including zero-framebuffer paths. No hardware or kernel access.\n";
}
