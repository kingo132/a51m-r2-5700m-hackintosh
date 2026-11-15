#pragma once
#include <stdint.h>
#include <stddef.h>

// Private layout of C3FA8B38-0702-3FCD-9878-C8FD05A7A724 only.
// The adapter must validate the loaded image and hold the ownership lock for
// State operations. Snapshot reads and the native callbacks run outside it.
namespace A51Tg {
constexpr size_t PathOffset=0x1B8, CachedOffset=0xDC;
constexpr size_t CacheField=PathOffset+CachedOffset;
inline bool fitsRel32(uintptr_t from,uintptr_t to) {
    if(from>UINTPTR_MAX-5) return false;
    uintptr_t next=from+5;
    return to>=next ? to-next<=0x7FFFFFFFULL : next-to<=0x80000000ULL;
}
template<class Reader> bool imageUUID(const Reader &reader,uintptr_t base,size_t size,const uint8_t *expected) {
    uint32_t h[8] {};
    if(size<sizeof(h) || base>UINTPTR_MAX-size || !reader(base,h,sizeof(h)) ||
       h[0]!=0xFEEDFACF || h[4]>128 || h[5]>0x10000 || h[5]>size-sizeof(h)) return false;
    uintptr_t pos=base+sizeof(h),end=pos+h[5];
    for(uint32_t i=0;i<h[4];++i) {
        uint32_t cmd[2] {};
        if(pos>end || end-pos<sizeof(cmd) || !reader(pos,cmd,sizeof(cmd)) ||
           cmd[1]<sizeof(cmd) || cmd[1]>end-pos) return false;
        if(cmd[0]==0x1B) {
            uint8_t actual[16] {};
            if(cmd[1]<24 || !reader(pos+8,actual,sizeof(actual))) return false;
            for(size_t n=0;n<sizeof(actual);++n) if(actual[n]!=expected[n]) return false;
            return true;
        }
        pos+=cmd[1];
    }
    return false;
}
struct Key {
    uintptr_t controller {};
    uint64_t registryId {};
    bool operator==(const Key &other) const {
        return controller==other.controller && registryId==other.registryId;
    }
};
struct View {
    uintptr_t path {},helper {},dal {},core {},owner {},handle {},stream {},context {},state {};
    uint32_t index {},streams {},streamId {},sink {},framebuffers {};
    int32_t cached {-1},native {-1};
    uint8_t connected {},online {},dcCount {};
    uint32_t stage {};
    bool eligible() const {
        return stage>=1 && index==0 && !(connected&1) && (online&1) &&
            streams==1 && streamId==0 && sink==0;
    }
};
template<class Reader,class T> bool read(const Reader &reader,uintptr_t p,size_t off,T &value) {
    return p && off<=0x10000 && p<=UINTPTR_MAX-off && reader(p+off,&value,sizeof(value));
}
template<class Reader> View inspect(const Reader &reader,uintptr_t controller,uintptr_t module) {
    View v {};uint8_t count=0;
    if(!read(reader,controller,0xBD,count) || !count || count>6 || controller>UINTPTR_MAX-PathOffset) return v;
    v.path=controller+PathOffset;
    if(!read(reader,v.path,0,v.index) || v.index!=0 ||
       !read(reader,v.path,0xD0,v.streams) || !read(reader,v.path,0xD8,v.streamId) ||
       !read(reader,v.path,CachedOffset,v.cached) || !read(reader,v.path,0xEC,v.sink) ||
       !read(reader,v.path,0x718,v.connected) || !read(reader,v.path,0x719,v.online)) return v;
    v.stage=1;
    uintptr_t table=0,query=0;
    if(!read(reader,controller,0x7938,v.helper) || !read(reader,v.helper,0x48,v.dal) ||
       !read(reader,v.dal,0,table) || !read(reader,table,0xD8,query) || query!=module+0x6BC98) return v;
    v.stage=2;
    if(!read(reader,v.dal,0x648,v.core) || !read(reader,v.core,0x1C,v.framebuffers) ||
       !v.framebuffers || v.framebuffers>6 || !read(reader,v.dal,0x470,v.owner) ||
       !read(reader,v.owner,0x10,v.handle) || !read(reader,v.handle,0x20,v.stream) ||
       !read(reader,v.stream,0x3C0,v.context)) return v;
    v.stage=3;
    uintptr_t core=0;
    if(!read(reader,v.context,0,core) || core!=v.core ||
       !read(reader,v.core,0x3E0,v.state) || !read(reader,v.state,0x1E0,v.dcCount) ||
       !v.dcCount || v.dcCount>6) return v;
    v.stage=4;
    for(uint32_t i=0;i<v.dcCount;++i) {
        uintptr_t stream=0;
        if(!read(reader,v.state,i*sizeof(uintptr_t),stream)) return v;
        if(stream==v.stream) {
            if(read(reader,v.state,0x30+i*0x48,v.native) && v.native>=0 && v.native<6) v.stage=5;
            return v;
        }
    }
    return v;
}
inline bool same(const View &a,const View &b) {
    return a.stage==b.stage && a.path==b.path && a.helper==b.helper && a.dal==b.dal &&
        a.core==b.core && a.owner==b.owner && a.handle==b.handle && a.stream==b.stream &&
        a.context==b.context && a.state==b.state && a.index==b.index && a.streams==b.streams &&
        a.streamId==b.streamId && a.sink==b.sink && a.framebuffers==b.framebuffers &&
        a.cached==b.cached && a.native==b.native && a.connected==b.connected &&
        a.online==b.online && a.dcCount==b.dcCount;
}
enum class Result : uint32_t {
    Skipped,Recovered,Refreshed,Unchanged,Cleared,NativeOwned,Stale,CompareFailed,Unavailable
};
struct State {
    uint64_t epoch {};
    uint32_t invalidating {};
    Key owner {};
    uintptr_t cache {};
    int32_t written {-1};
    uint64_t beginCache() {return ++epoch;}
    bool owns(Key key) const {return cache && owner==key;}
    void forget() {owner={};cache=0;written=-1;}
    // Never dereference a previous controller. Registry ID prevents reuse of a
    // freed object's address from creating ownership of the new object.
    template<class CAS> bool clear(Key key,const CAS &cas) {
        if(!owns(key)) return false;
        bool cleared=cache==key.controller+CacheField && cas(cache,written,-1);
        forget();return cleared;
    }
    template<class CAS> bool beginInvalidate(Key key,const CAS &cas) {
        ++epoch;++invalidating;
        return clear(key,cas); // before the native invalidation callback
    }
    void endInvalidate() {if(invalidating) --invalidating;++epoch;}
    template<class CAS> Result finishCache(Key key,uint64_t ticket,bool fixed,
                                          const View &a,const View &b,const CAS &cas) {
        if(ticket!=epoch || invalidating) return Result::Stale;
        if(!same(a,b) || b.path!=key.controller+PathOffset) return Result::Unavailable;
        if(!fixed || !b.eligible()) {
            // A connected online path has returned to the native cache owner.
            if((b.connected&1) && (b.online&1) && b.streams) {
                if(owns(key)) forget();return Result::NativeOwned;
            }
            return clear(key,cas) ? Result::Cleared : Result::Skipped;
        }
        if(b.stage!=5) return clear(key,cas) ? Result::Cleared : Result::Unavailable;
        bool updating=owns(key) && cache==b.path+CachedOffset && b.cached==written;
        if(!updating && b.cached!=-1) {
            if(owns(key)) forget();return Result::NativeOwned;
        }
        if(updating && b.cached==b.native) return Result::Unchanged;
        if(!cas(b.path+CachedOffset,b.cached,b.native)) {
            if(owns(key)) forget();return Result::CompareFailed;
        }
        // No other object is accessed when a replacement controller takes over.
        owner=key;cache=b.path+CachedOffset;written=b.native;
        return updating ? Result::Refreshed : Result::Recovered;
    }
};
} // namespace A51Tg
