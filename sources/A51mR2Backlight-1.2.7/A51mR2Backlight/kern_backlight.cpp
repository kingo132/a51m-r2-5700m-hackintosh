//
//  kern_backlight.cpp
//  A51mR2Backlight
//

#include <Headers/kern_api.hpp>

#include "kern_backlight.hpp"

void BacklightController::init() {
    SYSLOG("main", "initialising on Darwin %d.%d", getKernelVersion(), getKernelMinorVersion());
    tgCache.init();

    lilu.onKextLoadForce(nullptr, 0,
        [](void *user, KernelPatcher &patcher, size_t index,
           mach_vm_address_t address, size_t size) {
            static_cast<BacklightController *>(user)->processKext(
                patcher, index, address, size);
        }, this);

    appleBacklight.registerKexts();
    radeonBacklight.registerKexts();

    SYSLOG("main", "kext watchers registered");
}

void BacklightController::processKext(KernelPatcher &patcher, size_t index,
                                      mach_vm_address_t address, size_t size) {
    if (appleBacklight.processKext(patcher, index, address, size))
        return;

    if (radeonBacklight.processKext(patcher, index, address, size))
        tgCache.processKext(patcher, index, address, size);
}
