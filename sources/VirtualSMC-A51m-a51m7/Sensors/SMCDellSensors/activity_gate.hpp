// The existing audio/Bluetooth activity latch can be reset by its timer while
// a completion is releasing it. A checked load followed by fetch_sub can wrap
// zero to UINT32_MAX; use one linearizable reset and a saturating CAS release.
#ifndef SMC_DELL_ACTIVITY_GATE_HPP
#define SMC_DELL_ACTIVITY_GATE_HPP
#include <stdint.h>
#include <stdatomic.h>
namespace SMCDellActivity {
inline void reset(_Atomic(uint32_t) *active) {
    atomic_exchange_explicit(active,0U,memory_order_acq_rel);
}
inline bool release(_Atomic(uint32_t) *active) {
    auto count=atomic_load_explicit(active,memory_order_acquire);
    while(count) {
        if(atomic_compare_exchange_weak_explicit(active,&count,count-1,
                                               memory_order_acq_rel,memory_order_acquire))
            return true;
    }
    return false;
}
}
#endif
