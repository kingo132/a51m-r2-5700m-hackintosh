// Opt-in bridge into the native power-source dictionary. No iStat patch,
// SMC rating fabrication, firmware call, new timer or userspace service.
#ifndef A51M_ADAPTER_EXPORT_HPP
#define A51M_ADAPTER_EXPORT_HPP
#include "A51mAdapterPolicy.hpp"
#include "A51mAdapterPublication.hpp"
#include <Headers/kern_api.hpp>
#include <Headers/kern_time.hpp>
#include <IOKit/pwr_mgt/IOPMPowerSource.h>
#include <stdatomic.h>
namespace A51mAdapter {
static bool enabled = false;
static _Atomic(bool) routed = false;
static mach_vm_address_t originalCompletion = 0;
static const char *paths[] = {
    "/System/Library/Extensions/AppleSmartBatteryManager.kext/Contents/MacOS/AppleSmartBatteryManager"
};
static KernelPatcher::KextInfo kexts[] {
    {"com.apple.driver.AppleSmartBatteryManager", paths, 1, {true}, {}, KernelPatcher::KextInfo::Unloaded}
};
static const OSSymbol *detailsKey = nullptr;


static bool completion(IOService *service, const void *command) {
    uint32_t code = 0;
    if (command) memcpy(&code, command, sizeof(code));
    auto result = FunctionCast(completion, originalCompletion)(service, command);
    if (result && isAdapterUpdate(code) && atomic_load_explicit(&routed, memory_order_acquire)) publish(service, detailsKey);
    return result;
}

inline void init() {
    enabled = checkKernelArgument("-a51mbatadapter") &&
              checkKernelArgument("-a51mbatdell") && checkKernelArgument("-a51mbatmeta");
    if (!enabled || getKernelVersion() != KernelVersion::Tahoe) return;
    auto access = lilu.requestAccess();
    if (access != LiluAPI::Error::NoError) {
        SYSLOG("sbat", "adapter export unavailable: Lilu access %d", int(access));
        return;
    }
    detailsKey = OSSymbol::withCStringNoCopy("AdapterDetails");
    if (detailsKey) {
        auto registered = lilu.onKextLoad(kexts, 1,
        [](void *, KernelPatcher &patcher, size_t index, mach_vm_address_t address, size_t size) {
            if (index != kexts[0].loadIndex || atomic_load_explicit(&routed, memory_order_acquire) ||
                !knownImage(reinterpret_cast<const uint8_t *>(address), size)) return;
            KernelPatcher::RouteRequest request {
                "__ZN17AppleSmartBattery25smcReadKeyThreadCallGatedEP15CommandStruct_s",
                completion, originalCompletion
            };
            if (patcher.routeMultiple(index, &request, 1, address, size) && originalCompletion)
                atomic_store_explicit(&routed, true, memory_order_release);
            else {
                SYSLOG("sbat", "adapter export route unavailable: %d", int(patcher.getError()));
                patcher.clearError();
            }
        });
        if (registered != LiluAPI::Error::NoError)
            SYSLOG("sbat", "adapter export registration failed: %d", int(registered));
    }
    lilu.releaseAccess();
}
}
#endif
