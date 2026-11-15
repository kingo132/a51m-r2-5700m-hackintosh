#pragma once
#include <Headers/kern_patcher.hpp>
#include <IOKit/IOLocks.h>
#include "tg_cache_core.hpp"

class TgCachePatcher {
public:
    void init();
    void processKext(KernelPatcher &patcher,size_t index,mach_vm_address_t address,size_t size);
private:
    using Hook=int (*)(void *);
    using Copy=vm_size_t (*)(vm_offset_t,vm_offset_t,vm_size_t);
    struct Reader {
        Copy copy;
        bool operator()(uintptr_t p,void *out,size_t n) const;
    };
    struct Compare {
        bool operator()(uintptr_t p,int32_t expected,int32_t desired) const;
    };
    struct Counters {
        uint32_t cache {},recover {},refresh {},invalidate {},clear {},stale {},unavailable {},casMiss {},nativeFailure {};
        int32_t native {-1},cached {-1};
        uint32_t stage {};
    };
    static TgCachePatcher *callback;
    IOSimpleLock *lock {};
    A51Tg::State state {};
    Counters counters {};
    Copy safeCopy {};
    uintptr_t module {};
    mach_vm_address_t originalCache {},originalInvalidate {};
    bool enabled {},ready {};
    bool fixedInternal(void *controller) const;
    void publish(const char *status);
    static int wrapCache(void *controller);
    static int wrapInvalidate(void *controller);
};
