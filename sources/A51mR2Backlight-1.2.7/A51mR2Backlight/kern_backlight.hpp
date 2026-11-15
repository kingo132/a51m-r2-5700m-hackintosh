//
//  kern_backlight.hpp
//  A51mR2Backlight
//
//  Top-level coordinator for the standalone Area-51m R2 backlight plugin.
//  Platform-specific patching lives in the AppleBacklight and Radeon modules.
//

#ifndef kern_backlight_hpp
#define kern_backlight_hpp

#include <Headers/kern_patcher.hpp>

#include "kern_applebacklight.hpp"
#include "kern_radeonbacklight.hpp"
#include "kern_tgcache.hpp"

class BacklightController {
public:
    void init();

private:
    AppleBacklightPatcher appleBacklight;
    RadeonBacklightPatcher radeonBacklight;
    TgCachePatcher tgCache;

    void processKext(KernelPatcher &patcher, size_t index,
                     mach_vm_address_t address, size_t size);
};

#endif /* kern_backlight_hpp */
