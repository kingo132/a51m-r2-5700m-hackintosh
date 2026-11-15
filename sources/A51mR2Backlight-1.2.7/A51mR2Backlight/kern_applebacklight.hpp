//
//  kern_applebacklight.hpp
//  A51mR2Backlight
//

#ifndef kern_applebacklight_hpp
#define kern_applebacklight_hpp

#include <Headers/kern_patcher.hpp>
#include <IOKit/IOService.h>

class IODisplay;

class AppleBacklightPatcher {
public:
    void registerKexts();
    bool processKext(KernelPatcher &patcher, size_t index,
                     mach_vm_address_t address, size_t size);

private:
    static AppleBacklightPatcher *callback;

    mach_vm_address_t orgApplePanelSetDisplay {0};
    mach_vm_address_t orgApplePanelDoIntegerSet {0};

    bool appleBacklightHooksReady {false};
    bool mccsSuppressionReady {false};
    bool panelProfilesReady {false};

    // Experimental fixed logical brightness grid.
    // Disabled unless -a51bklfixed16 is present.
    bool fixedBrightnessSteps {false};
    bool fixedBrightnessHookReady {false};

    uint32_t logicalBrightnessWriteCount {0};
    uint32_t logicalBrightnessSnapCount {0};
    uint32_t lastLogicalBrightnessRequest {0};
    uint32_t lastLogicalBrightnessSnapped {0};
    bool experimentalPanelProfile {false};

    uint32_t panelSetDisplayCount {0};
    uint32_t panelProfileRepairCount {0};

    void patchAppleBacklight(KernelPatcher &patcher, size_t index,
                             mach_vm_address_t address, size_t size);
    void patchMccsControl(KernelPatcher &patcher, size_t index,
                          mach_vm_address_t address, size_t size);

    bool ensurePanelProfiles(IOService *panelService);
    void publishDiagnostics();

    static bool wrapApplePanelSetDisplay(IOService *that, IODisplay *display);

    static IOReturn wrapApplePanelDoIntegerSet(
        IOService *that,
        OSDictionary *parameters,
        const OSSymbol *key,
        uint32_t value);
    static size_t wrapFunctionReturnZero();
};

#endif /* kern_applebacklight_hpp */
