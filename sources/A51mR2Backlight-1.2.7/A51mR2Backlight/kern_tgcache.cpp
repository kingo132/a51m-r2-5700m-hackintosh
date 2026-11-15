#include <Headers/kern_api.hpp>
#include <IOKit/IOService.h>
#include <libkern/OSAtomic.h>
#include <libkern/c++/OSData.h>
#include <libkern/c++/OSNumber.h>
#include "kern_diagnostics.hpp"
#include "kern_tgcache.hpp"
#include "tg_cache_layout.hpp"

TgCachePatcher *TgCachePatcher::callback {};

bool TgCachePatcher::Reader::operator()(uintptr_t p,void *out,size_t n) const {
    return copy && p>=0xFFFFFF0000000000ULL && n && n<=512 && p<=UINTPTR_MAX-n &&
        copy(p,reinterpret_cast<vm_offset_t>(out),n)==n;
}
bool TgCachePatcher::Compare::operator()(uintptr_t p,int32_t expected,int32_t desired) const {
    return OSCompareAndSwap(static_cast<uint32_t>(expected),static_cast<uint32_t>(desired),
                            reinterpret_cast<volatile UInt32 *>(p));
}
void TgCachePatcher::init() {
    callback=this;
    enabled=!checkKernelArgument("-a51tgcacheoff");
    if(enabled) lock=IOSimpleLockAlloc();
    if(enabled && !lock) enabled=false;
    publish(enabled ? "waiting-for-framebuffer" : "disabled");
}

void TgCachePatcher::processKext(KernelPatcher &patcher,size_t index,mach_vm_address_t address,size_t size) {
    if(!enabled) return;
    if(getKernelVersion()!=KernelVersion::Tahoe) {publish("unsupported-kernel");return;}
    // Resolve the live kernel symbol through Lilu; never use an unslid address
    // from a userspace kext listing or a fixed kernel-function offset.
    auto copy=patcher.solveSymbol(KernelPatcher::KernelID,"_ml_nofault_copy");
    if(!copy || patcher.getError()!=KernelPatcher::Error::NoError) {
        patcher.clearError();publish("safe-reader-unavailable");return;
    }
    safeCopy=reinterpret_cast<Copy>(copy);
    Reader reader {safeCopy};
    if(!A51Tg::imageUUID(reader,address,size,A51TgLayout::DriverUUID)) {
        publish("unsupported-framebuffer-uuid");return;
    }
    for(const auto &anchor:A51TgLayout::Anchors) {
        uint8_t code[sizeof(anchor.bytes)] {};
        if(anchor.offset>size || sizeof(code)>size-anchor.offset ||
           !reader(address+anchor.offset,code,sizeof(code)) || memcmp(code,anchor.bytes,sizeof(code))) {
            publish("framebuffer-code-mismatch");return;
        }
    }
    constexpr const char *cacheSymbol="__ZN34AMDRadeonX6000_AmdRadeonController14cacheTgIndicesEv";
    constexpr const char *invalidateSymbol="__ZN34AMDRadeonX6000_AmdRadeonController25invalidateCachedTgIndicesEv";
    auto cache=patcher.solveSymbol(index,cacheSymbol);
    auto invalidate=patcher.solveSymbol(index,invalidateSymbol);
    if(patcher.getError()!=KernelPatcher::Error::NoError || cache!=address+A51TgLayout::CacheOffset ||
       invalidate!=address+A51TgLayout::InvalidateOffset) {
        patcher.clearError();publish("framebuffer-symbol-layout-mismatch");return;
    }
    // Lilu copies displaced instructions without relocating conditional jumps.
    // A 5-byte route displaces only the PIC first 6/7-byte load. A 14-byte
    // fallback could copy the following branch, so it is deliberately forbidden.
    if(!A51Tg::fitsRel32(cache,reinterpret_cast<uintptr_t>(wrapCache)) ||
       !A51Tg::fitsRel32(invalidate,reinterpret_cast<uintptr_t>(wrapInvalidate))) {
        publish("short-route-out-of-range");return;
    }
    module=address;
    KernelPatcher::RouteRequest routes[] {
        {invalidateSymbol,wrapInvalidate,originalInvalidate},
        {cacheSymbol,wrapCache,originalCache}
    };
    ready=patcher.routeMultipleShort(index,routes,address,size,true,false);
    if(!ready) {
        // A partially installed wrapper remains pass-through until both routes
        // succeed. Brightness hooks have their own independent ready state.
        patcher.clearError();publish("hook-install-failed-pass-through");return;
    }
    publish("ready");
    SYSLOG("tgcache","exact-build fixed-panel TG cache maintenance ready");
}

bool TgCachePatcher::fixedInternal(void *controller) const {
    auto pci=static_cast<IOService *>(controller)->getProvider();
    if(!pci) return false;
    auto number=[pci](const char *key,uint32_t &out) {
        auto p=pci->getProperty(key);
        if(auto n=OSDynamicCast(OSNumber,p)) {out=n->unsigned32BitValue();return true;}
        if(auto d=OSDynamicCast(OSData,p)) {
            if(d->getLength()==sizeof(out)) {memcpy(&out,d->getBytesNoCopy(),sizeof(out));return true;}
        }
        return false;
    };
    uint32_t vendor=0,device=0,fixed=0;
    return number("vendor-id",vendor) && vendor==0x1002 && number("device-id",device) &&
        device==0x731F && number("CFG_LINK_FIXED_MAP",fixed) && (fixed&1);
}

int TgCachePatcher::wrapCache(void *controller) {
    auto self=callback;
    if(!self->ready) return reinterpret_cast<Hook>(self->originalCache)(controller);
    A51Tg::Key key {reinterpret_cast<uintptr_t>(controller),static_cast<IOService *>(controller)->getRegistryEntryID()};
    auto irq=IOSimpleLockLockDisableInterrupt(self->lock);
    auto ticket=self->state.beginCache();++self->counters.cache;
    IOSimpleLockUnlockEnableInterrupt(self->lock,irq);
    // Preserve native work, result, and callback order. No driver callback,
    // allocator, registry query or no-fault walk runs with the spin lock held.
    int result=reinterpret_cast<Hook>(self->originalCache)(controller);
    if(result!=0) {
        irq=IOSimpleLockLockDisableInterrupt(self->lock);++self->counters.nativeFailure;
        IOSimpleLockUnlockEnableInterrupt(self->lock,irq);self->publish("native-cache-failed");return result;
    }
    bool fixed=key.registryId && self->fixedInternal(controller);
    Reader reader {self->safeCopy};
    auto a=A51Tg::inspect(reader,key.controller,self->module);
    auto b=A51Tg::inspect(reader,key.controller,self->module);
    irq=IOSimpleLockLockDisableInterrupt(self->lock);
    auto action=self->state.finishCache(key,ticket,fixed,a,b,Compare {});
    self->counters.native=b.native;self->counters.cached=b.cached;self->counters.stage=b.stage;
    switch(action) {
        case A51Tg::Result::Recovered:++self->counters.recover;break;
        case A51Tg::Result::Refreshed:++self->counters.refresh;break;
        case A51Tg::Result::Cleared:++self->counters.clear;break;
        case A51Tg::Result::Stale:++self->counters.stale;break;
        case A51Tg::Result::CompareFailed:++self->counters.casMiss;break;
        case A51Tg::Result::Unavailable:++self->counters.unavailable;break;
        default:break;
    }
    IOSimpleLockUnlockEnableInterrupt(self->lock,irq);
    const char *status="native-or-unchanged";
    if(action==A51Tg::Result::Recovered) status="recovered";
    else if(action==A51Tg::Result::Refreshed) status="refreshed";
    else if(action==A51Tg::Result::Cleared) status="cleared";
    else if(action==A51Tg::Result::Unavailable) status="native-mapping-unavailable";
    else if(action==A51Tg::Result::Stale) status="superseded-mode-event";
    else if(action==A51Tg::Result::CompareFailed) status="cache-changed-by-another-writer";
    self->publish(status);return result;
}

int TgCachePatcher::wrapInvalidate(void *controller) {
    auto self=callback;
    if(!self->ready) return reinterpret_cast<Hook>(self->originalInvalidate)(controller);
    A51Tg::Key key {reinterpret_cast<uintptr_t>(controller),static_cast<IOService *>(controller)->getRegistryEntryID()};
    auto irq=IOSimpleLockLockDisableInterrupt(self->lock);
    ++self->counters.invalidate;
    if(self->state.beginInvalidate(key,Compare {})) ++self->counters.clear;
    IOSimpleLockUnlockEnableInterrupt(self->lock,irq);
    int result=reinterpret_cast<Hook>(self->originalInvalidate)(controller);
    irq=IOSimpleLockLockDisableInterrupt(self->lock);
    self->state.endInvalidate();
    IOSimpleLockUnlockEnableInterrupt(self->lock,irq);
    self->publish("invalidated");return result;
}

void TgCachePatcher::publish(const char *status) {
    Counters c {};int32_t owned=-1;uint64_t epoch=0;
    if(lock) {
        auto irq=IOSimpleLockLockDisableInterrupt(lock);
        c=counters;owned=state.written;epoch=state.epoch;
        IOSimpleLockUnlockEnableInterrupt(lock,irq);
    }
    A51Diagnostics::setBool("TgCacheEnabled",enabled);
    A51Diagnostics::setBool("TgCacheHooksReady",ready);
    if(auto service=A51Diagnostics::service()) service->setProperty("TgCacheState",status);
    A51Diagnostics::setUInt32("TgCacheEvents",c.cache);
    A51Diagnostics::setUInt32("TgCacheRecoveries",c.recover);
    A51Diagnostics::setUInt32("TgCacheRefreshes",c.refresh);
    A51Diagnostics::setUInt32("TgCacheInvalidations",c.invalidate);
    A51Diagnostics::setUInt32("TgCacheClears",c.clear);
    A51Diagnostics::setUInt32("TgCacheStaleEvents",c.stale);
    A51Diagnostics::setUInt32("TgCacheReadFailures",c.unavailable);
    A51Diagnostics::setUInt32("TgCacheCompareFailures",c.casMiss);
    A51Diagnostics::setUInt32("TgCacheNativeFailures",c.nativeFailure);
    A51Diagnostics::setUInt32("TgCacheLastNative",static_cast<uint32_t>(c.native));
    A51Diagnostics::setUInt32("TgCacheLastCachedBefore",static_cast<uint32_t>(c.cached));
    A51Diagnostics::setUInt32("TgCacheOwnedTg",static_cast<uint32_t>(owned));
    A51Diagnostics::setUInt32("TgCacheReadStage",c.stage);
    A51Diagnostics::setUInt32("TgCacheEpoch",static_cast<uint32_t>(epoch));
}
