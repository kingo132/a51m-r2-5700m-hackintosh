//
//  kern_radeonbacklight.cpp
//  A51mR2Backlight
//
//  Navi10 internal-panel brightness routing for the Alienware Area-51m R2.
//

#include <Headers/kern_api.hpp>
#include <Headers/kern_iokit.hpp>
#include <Headers/kern_time.hpp>
#include <IOKit/graphics/IODisplay.h>

#include "kern_diagnostics.hpp"
#include "kern_radeonbacklight.hpp"
#include "kern_radeon_signatures.hpp"

namespace {

const char *pathRadeonX6000Framebuffer[] {
    "/System/Library/Extensions/AMDRadeonX6000Framebuffer.kext/Contents/MacOS/AMDRadeonX6000Framebuffer"
};

KernelPatcher::KextInfo kextRadeonX6000Framebuffer {
    "com.apple.kext.AMDRadeonX6000Framebuffer",
    pathRadeonX6000Framebuffer,
    arrsize(pathRadeonX6000Framebuffer),
    {},
    {},
    KernelPatcher::KextInfo::Unloaded
};

constexpr UInt32 BacklightAttribute = static_cast<UInt32>('bklt');
constexpr uint32_t FullBrightnessPwmLegacy = 0x1FF00;
constexpr uint32_t FullBrightnessPwmU16_16 = 0x10000;
constexpr uint32_t MaxEightBitBacklightBelowFull = 0xFE;

bool hasNativeFunctionName(mach_vm_address_t address, size_t size,
                           mach_vm_address_t function, size_t prefixSize,
                           const char *name) {
    constexpr size_t instructionSize = 7;
    if (function < address || function - address > size ||
        prefixSize > size - (function - address) ||
        size - (function - address) - prefixSize < instructionSize)
        return false;
    const auto instruction = reinterpret_cast<const uint8_t *>(function + prefixSize);
    // REX.W / REX.WR + LEA reg,[RIP+disp32]. No live panel fields are read.
    if ((instruction[0] != 0x48 && instruction[0] != 0x4C) ||
        instruction[1] != 0x8D || (instruction[2] & 0xC7) != 0x05)
        return false;
    int32_t displacement = 0;
    memcpy(&displacement, instruction + 3, sizeof(displacement));
    const auto target = static_cast<mach_vm_address_t>(
        static_cast<int64_t>(function + prefixSize + instructionSize) + displacement);
    const auto length = strlen(name) + 1;
    return target >= address && target - address <= size &&
        size - (target - address) >= length &&
        memcmp(reinterpret_cast<const void *>(target), name, length) == 0;
}

} // namespace

RadeonBacklightPatcher *RadeonBacklightPatcher::callback {nullptr};

void RadeonBacklightPatcher::registerKexts() {
    callback = this;

    useLegacyPwmMapping = checkKernelArgument("-a51bkllegacycurve");
    useEightBitPwmMapping = checkKernelArgument("-a51bkl8bit");
    restoreAfterPanelInit = !checkKernelArgument("-a51bklnorestore");

    const char *mappingName = useLegacyPwmMapping
        ? "legacy-100-step"
        : (useEightBitPwmMapping ? "linear-8-bit" : "linear-u16.16");

    A51Diagnostics::setString(
        "PwmMapping",
        mappingName);
    A51Diagnostics::setBool("RestoreAfterPanelInit", restoreAfterPanelInit);

    lilu.onKextLoadForce(&kextRadeonX6000Framebuffer);
}

bool RadeonBacklightPatcher::processKext(KernelPatcher &patcher, size_t index,
                                         mach_vm_address_t address, size_t size) {
    if (kextRadeonX6000Framebuffer.loadIndex != index)
        return false;

    SYSLOG("radeon", "processing AMDRadeonX6000Framebuffer");
    installHooks(patcher, index, address, size);
    return true;
}

bool RadeonBacklightPatcher::installHooks(KernelPatcher &patcher, size_t index,
                                          mach_vm_address_t address, size_t size) {
    if (!routeFramebufferMethods(patcher, index, address, size))
        return false;

    if (!resolveAndRoutePwmFunctions(patcher, index, address, size))
        return false;

    hooksReady = true;
    publishDiagnostics();
    SYSLOG("radeon", "RX 5000 PWM brightness hooks are ready (%s mapping)",
           useLegacyPwmMapping
               ? "legacy"
               : (useEightBitPwmMapping ? "linear-8-bit" : "linear-u16.16"));
    return true;
}

bool RadeonBacklightPatcher::routeFramebufferMethods(KernelPatcher &patcher, size_t index,
                                                      mach_vm_address_t address, size_t size) {
    KernelPatcher::RouteRequest requests[] {
        {
            "__ZN35AMDRadeonX6000_AmdRadeonFramebuffer25setAttributeForConnectionEijm",
            wrapFramebufferSetAttribute,
            orgFramebufferSetAttribute
        },
        {
            "__ZN35AMDRadeonX6000_AmdRadeonFramebuffer25getAttributeForConnectionEijPm",
            wrapFramebufferGetAttribute,
            orgFramebufferGetAttribute
        },
    };

    if (!patcher.routeMultiple(index, requests, address, size, true, true)) {
        SYSLOG("radeon", "failed to route framebuffer brightness methods");
        patcher.clearError();
        return false;
    }

    SYSLOG("radeon", "framebuffer brightness methods routed");
    return true;
}

bool RadeonBacklightPatcher::resolveAndRoutePwmFunctions(KernelPatcher &patcher, size_t index,
                                                         mach_vm_address_t address, size_t size) {
    const auto signatures = signaturesForCurrentKernel();

    const auto panelInit = solveSymbolOrPattern(
        patcher, index, address, size,
        "_dce_panel_cntl_hw_init", signatures.panelInit);
    if (panelInit == 0)
        return false;

    const auto driverSetBacklight = solveSymbolOrPattern(
        patcher, index, address, size,
        "_dce_driver_set_backlight", signatures.setBacklight);
    if (driverSetBacklight == 0)
        return false;

    const auto getBacklight = solveSymbolOrPattern(
        patcher, index, address, size,
        "_dce_get_16_bit_backlight_from_pwm", signatures.getBacklight);
    if (getBacklight == 0)
        return false;

    const BytePattern storePattern {
        A51RadeonSignatures::StoreBacklight,
        sizeof(A51RadeonSignatures::StoreBacklight), "dce_store_backlight_level"
    };
    const auto storeBacklight = solveSymbolOrPattern(
        patcher, index, address, size, "_dce_store_backlight_level", storePattern);
    if (storeBacklight == 0)
        return false;

    // Both newly used routines need their unique prefix AND native name.
    if (!hasNativeFunctionName(address, size, storeBacklight, storePattern.size,
                               "dce_store_backlight_level") ||
        !hasNativeFunctionName(address, size, getBacklight, signatures.getBacklight.size,
                               "dce_get_16_bit_backlight_from_pwm")) {
        SYSLOG("radeon", "native brightness store/read identity validation failed");
        return false;
    }

    orgDcePanelCntlHwInit = patcher.routeFunction(
        panelInit,
        reinterpret_cast<mach_vm_address_t>(wrapDcePanelCntlHwInit),
        true);

    if (patcher.getError() != KernelPatcher::Error::NoError ||
        orgDcePanelCntlHwInit == 0) {
        SYSLOG("radeon", "failed to route dce_panel_cntl_hw_init (%d)",
               patcher.getError());
        patcher.clearError();
        return false;
    }

    orgDceDriverSetBacklight =
        reinterpret_cast<t_DceDriverSetBacklight>(driverSetBacklight);
    orgDceStoreBacklight = reinterpret_cast<t_DceStoreBacklight>(storeBacklight);
    orgDceGetBacklight = reinterpret_cast<t_DceGetBacklight>(getBacklight);

    SYSLOG("radeon", "private PWM functions resolved and panel-init routed");
    return true;
}

RadeonBacklightPatcher::SignatureSet RadeonBacklightPatcher::signaturesForCurrentKernel() {
    if (getKernelVersion() >= KernelVersion::Sonoma) {
        return {
            {A51RadeonSignatures::PanelInitModern, sizeof(A51RadeonSignatures::PanelInitModern), "dce_panel_cntl_hw_init"},
            {A51RadeonSignatures::SetBacklightModern, sizeof(A51RadeonSignatures::SetBacklightModern), "dce_driver_set_backlight"},
            {A51RadeonSignatures::GetBacklightModern, sizeof(A51RadeonSignatures::GetBacklightModern), "dce_get_16_bit_backlight_from_pwm"}
        };
    }

    const BytePattern getter = getKernelVersion() >= KernelVersion::Monterey
        ? BytePattern {A51RadeonSignatures::GetBacklightMonterey, sizeof(A51RadeonSignatures::GetBacklightMonterey), "dce_get_16_bit_backlight_from_pwm"}
        : BytePattern {A51RadeonSignatures::GetBacklightBigSur, sizeof(A51RadeonSignatures::GetBacklightBigSur), "dce_get_16_bit_backlight_from_pwm"};

    return {
        {A51RadeonSignatures::PanelInitLegacy, sizeof(A51RadeonSignatures::PanelInitLegacy), "dce_panel_cntl_hw_init"},
        {A51RadeonSignatures::SetBacklightLegacy, sizeof(A51RadeonSignatures::SetBacklightLegacy), "dce_driver_set_backlight"},
        getter
    };
}

mach_vm_address_t RadeonBacklightPatcher::findUniquePattern(mach_vm_address_t address,
                                                            size_t size,
                                                            const BytePattern &pattern) {
    if (address == 0 || pattern.bytes == nullptr || pattern.size == 0 || size < pattern.size)
        return 0;

    const auto base = reinterpret_cast<const uint8_t *>(address);
    mach_vm_address_t found {0};
    size_t matches {0};

    for (size_t offset = 0; offset <= size - pattern.size; ++offset) {
        bool equal = true;

        for (size_t i = 0; i < pattern.size; ++i) {
            if (base[offset + i] != pattern.bytes[i]) {
                equal = false;
                break;
            }
        }

        if (!equal)
            continue;

        found = address + offset;
        if (++matches > 1)
            break;
    }

    if (matches == 1) {
        DBGLOG("radeon", "found unique %s signature at %p",
               pattern.name, reinterpret_cast<void *>(found));
        return found;
    }

    SYSLOG("radeon", "%s signature match count is %lu; refusing unsafe hook",
           pattern.name, matches);
    return 0;
}

mach_vm_address_t RadeonBacklightPatcher::solveSymbolOrPattern(
    KernelPatcher &patcher, size_t index,
    mach_vm_address_t address, size_t size,
    const char *symbol, const BytePattern &pattern) {

    auto solved = patcher.solveSymbol<mach_vm_address_t>(
        index, symbol, address, size);

    if (patcher.getError() == KernelPatcher::Error::NoError && solved != 0) {
        DBGLOG("radeon", "resolved %s by symbol at %p",
               pattern.name, reinterpret_cast<void *>(solved));
        return solved;
    }

    patcher.clearError();
    DBGLOG("radeon", "%s symbol unavailable; trying validated signature",
           pattern.name);
    return findUniquePattern(address, size, pattern);
}

void RadeonBacklightPatcher::refreshBrightnessStateFromRegistry() {
    OSDictionary *matching = IOService::serviceMatching("AppleBacklightDisplay");
    if (matching == nullptr) {
        DBGLOG("radeon", "AppleBacklightDisplay matching dictionary is unavailable");
        return;
    }

    OSIterator *iterator = IOService::getMatchingServices(matching);
    if (iterator == nullptr) {
        matching->release();
        DBGLOG("radeon", "AppleBacklightDisplay service is unavailable");
        return;
    }

    auto display = OSDynamicCast(IORegistryEntry, iterator->getNextObject());
    if (display != nullptr) {
        auto parameters = OSDynamicCast(
            OSDictionary, display->getProperty("IODisplayParameters"));
        auto linearBrightness = parameters
            ? OSDynamicCast(OSDictionary, parameters->getObject("linear-brightness"))
            : nullptr;
        auto maximum = linearBrightness
            ? OSDynamicCast(OSNumber, linearBrightness->getObject("max"))
            : nullptr;
        auto current = linearBrightness
            ? OSDynamicCast(OSNumber, linearBrightness->getObject("value"))
            : nullptr;

        if (maximum != nullptr && maximum->unsigned32BitValue() != 0)
            maxBrightness = maximum->unsigned32BitValue();

        if (!currentBrightnessValid && current != nullptr) {
            currentBrightness = current->unsigned32BitValue();
            currentBrightnessValid = true;
            DBGLOG("radeon", "initial brightness from AppleBacklight is 0x%x / 0x%x",
                   currentBrightness, maxBrightness);
        }
    }

    iterator->release();
    matching->release();
    publishDiagnostics();
}

void RadeonBacklightPatcher::publishDiagnostics() {
    A51Diagnostics::setBool("RadeonHooksReady", hooksReady);
    A51Diagnostics::setBool("PanelControllerCaptured", panelController != nullptr);
    A51Diagnostics::setBool("CurrentBrightnessValid", currentBrightnessValid);
    A51Diagnostics::setBool("RestoreAfterPanelInit", restoreAfterPanelInit);
    A51Diagnostics::setString(
        "PwmMapping",
        useLegacyPwmMapping
            ? "legacy-100-step"
            : (useEightBitPwmMapping ? "linear-8-bit" : "linear-u16.16"));
    A51Diagnostics::setUInt32("PanelInitCount", panelInitCount);
    A51Diagnostics::setUInt32("BrightnessWriteCount", brightnessWriteCount);
    A51Diagnostics::setUInt32("BrightnessReadCount", brightnessReadCount);
    A51Diagnostics::setUInt32("BrightnessCapabilityFallbackCount",
                              brightnessCapabilityFallbackCount);
    A51Diagnostics::setUInt32("BrightnessRestoreCount", brightnessRestoreCount);
    A51Diagnostics::setUInt32("CurrentBrightness", currentBrightness);
    A51Diagnostics::setUInt32("MaxBrightness", maxBrightness);
    A51Diagnostics::setUInt32("LastPWM", lastPwmValue);
    A51Diagnostics::setUInt32("LastBrightnessRequest", lastBrightnessRequest);
    A51Diagnostics::setUInt32("BrightnessClampCount", brightnessClampCount);
    A51Diagnostics::setUInt32("IgnoredExternalBrightnessWrites", externalBrightnessWriteCount);
    A51Diagnostics::setUInt32("IgnoredExternalBrightnessReads", externalBrightnessReadCount);
    A51Diagnostics::setBool("NativeBrightnessStoreReady", orgDceStoreBacklight != nullptr);
    A51Diagnostics::setUInt32("NativeBrightnessStoreCount", nativeBrightnessStoreCount);
    A51Diagnostics::setBool("NativeBrightnessReadReady", orgDceGetBacklight != nullptr);
    A51Diagnostics::setUInt32("LastPanelInitBrightness", lastPanelInitBrightness);
    A51Diagnostics::setUInt32("LastRestoredPanelBrightness", lastRestoredPanelBrightness);
    if (auto service = A51Diagnostics::service())
        service->setProperty("InternalBrightnessFramebufferId", internalFramebufferRegistryId, 64);

    A51Diagnostics::setUInt32(
        "LastBrightnessIntervalMs",
        lastBrightnessIntervalMs);
    A51Diagnostics::setUInt32(
        "LastBrightnessDelta",
        lastBrightnessDelta);
    A51Diagnostics::setUInt32(
        "BrightnessBurstCount",
        brightnessBurstCount);
    A51Diagnostics::setUInt32(
        "CurrentBurstWriteCount",
        currentBurstWriteCount);
    A51Diagnostics::setUInt32(
        "MaxBurstWriteCount",
        maxBurstWriteCount);
}

bool RadeonBacklightPatcher::isInternalConnection(IOService *framebuffer,
                                                 IOIndex connectIndex) const {
    if (framebuffer == nullptr || orgFramebufferGetAttribute == 0)
        return false;

    // Ask the native connection for its published flags. This works during the
    // early AppleIntelPanelA capability probe, before AppleBacklightDisplay is
    // created. Calling the original method avoids entering our bklt override.
    uintptr_t flags = 0;
    const auto result = FunctionCast(wrapFramebufferGetAttribute,
                                    orgFramebufferGetAttribute)(
        framebuffer, connectIndex, kConnectionFlags, &flags);
    return result == kIOReturnSuccess && (flags & kIOConnectionBuiltIn) != 0;
}

void RadeonBacklightPatcher::applyCurrentBrightness(const char *reason) {
    if (!hooksReady ||
        !currentBrightnessValid ||
        panelController == nullptr ||
        orgDceDriverSetBacklight == nullptr ||
        maxBrightness == 0) {
        return;
    }

    lastPwmValue = convertBrightnessToPwm(
        currentBrightness,
        maxBrightness,
        useLegacyPwmMapping,
        useEightBitPwmMapping);

    orgDceDriverSetBacklight(panelController, lastPwmValue);

    // AMD's hardware initialisation restores stored_backlight_registers.
    // Its low-level PWM setter does not refresh that native resume cache.
    // Keep it coherent after the hardware write through AMD's own store API.
    if (orgDceStoreBacklight != nullptr) {
        orgDceStoreBacklight(panelController);
        ++nativeBrightnessStoreCount;
    }

    DBGLOG("radeon", "%s brightness=0x%x max=0x%x pwm=0x%x",
           reason,
           currentBrightness,
           maxBrightness,
           lastPwmValue);

    publishDiagnostics();
}

uint32_t RadeonBacklightPatcher::convertBrightnessToPwm(uint32_t value,
                                                        uint32_t maxValue,
                                                        bool legacyMapping,
                                                        bool eightBitMapping) {
    if (maxValue == 0)
        return 0;

    if (legacyMapping) {
        if (value >= maxValue)
            return FullBrightnessPwmLegacy;

        const uint64_t percent = static_cast<uint64_t>(value) * 100ULL / maxValue;
        return static_cast<uint32_t>((percent * 0xFFULL / 100ULL) << 8U);
    }

    if (eightBitMapping) {
        // Exact 1.2.1 mapping, kept only as an A/B fallback.
        if (value >= maxValue)
            return FullBrightnessPwmLegacy;

        uint64_t level =
            (static_cast<uint64_t>(value) * 0xFFULL + maxValue / 2ULL) / maxValue;
        if (level > MaxEightBitBacklightBelowFull)
            level = MaxEightBitBacklightBelowFull;

        return static_cast<uint32_t>(level << 8U);
    }

    // dce_driver_set_backlight() consumes a U16.16-normalised level. Feed it
    // the full precision Apple linear-brightness ratio instead of first
    // quantising that ratio to 8 bits. 1.0 is exactly 0x10000.
    if (value >= maxValue)
        return FullBrightnessPwmU16_16;

    uint64_t pwm =
        (static_cast<uint64_t>(value) * FullBrightnessPwmU16_16 +
         maxValue / 2ULL) / maxValue;
    if (pwm > FullBrightnessPwmU16_16)
        pwm = FullBrightnessPwmU16_16;

    return static_cast<uint32_t>(pwm);
}

uint32_t RadeonBacklightPatcher::wrapDcePanelCntlHwInit(void *panelController) {
    callback->panelController = panelController;
    ++callback->panelInitCount;
    callback->refreshBrightnessStateFromRegistry();

    uint32_t result = FunctionCast(
        wrapDcePanelCntlHwInit,
        callback->orgDcePanelCntlHwInit)(panelController);
    callback->lastPanelInitBrightness = result;

    if (callback->panelInitCount == 1) {
        SYSLOG("radeon", "panel controller captured; max brightness 0x%x current 0x%x valid=%d",
               callback->maxBrightness,
               callback->currentBrightness,
               callback->currentBrightnessValid);
    } else {
        DBGLOG("radeon", "panel init #%u; max 0x%x current 0x%x valid=%d",
               callback->panelInitCount,
               callback->maxBrightness,
               callback->currentBrightness,
               callback->currentBrightnessValid);
    }

    if (callback->restoreAfterPanelInit &&
        callback->panelInitCount > 1 &&
        callback->currentBrightnessValid) {
        ++callback->brightnessRestoreCount;
        callback->applyCurrentBrightness("restored after panel init");
        // hw_init returns the hardware brightness, not a status code. The
        // caller must receive the post-restore readback, rather than the old
        // value observed before our restore. Keep AMD's native return units.
        if (callback->hooksReady && callback->orgDceGetBacklight != nullptr) {
            result = callback->orgDceGetBacklight(panelController);
            callback->lastRestoredPanelBrightness = result;
        }
    }

    callback->publishDiagnostics();
    return result;
}

IOReturn RadeonBacklightPatcher::wrapFramebufferSetAttribute(
    IOService *framebuffer, IOIndex connectIndex,
    IOSelect attribute, uintptr_t value) {

    IOReturn result = FunctionCast(
        wrapFramebufferSetAttribute,
        callback->orgFramebufferSetAttribute)(
            framebuffer, connectIndex, attribute, value);

    if (attribute != BacklightAttribute)
        return result;

    // The routed class is shared by every Radeon output. An external output
    // must neither advertise the panel's brightness control nor overwrite its
    // single panel-controller cache during display reconfiguration.
    if (!callback->isInternalConnection(framebuffer, connectIndex)) {
        ++callback->externalBrightnessWriteCount;
        callback->publishDiagnostics();
        return result;
    }
    callback->internalFramebufferRegistryId = framebuffer->getRegistryEntryID();

    ++callback->brightnessWriteCount;

    const uint32_t request = static_cast<uint32_t>(value);
    const uint32_t previous = callback->currentBrightness;

    const uint64_t nowNs = getCurrentTimeNs();

    if (callback->lastBrightnessWriteNs != 0) {
        const uint64_t intervalNs =
            nowNs - callback->lastBrightnessWriteNs;

        uint64_t intervalMs64 = intervalNs / 1000000ULL;
        if (intervalMs64 > 0xFFFFFFFFULL)
            intervalMs64 = 0xFFFFFFFFULL;

        callback->lastBrightnessIntervalMs =
            static_cast<uint32_t>(intervalMs64);

        // Treat writes within 500 ms as one transition burst.
        if (callback->lastBrightnessIntervalMs <= 500) {
            ++callback->currentBurstWriteCount;
        } else {
            ++callback->brightnessBurstCount;
            callback->currentBurstWriteCount = 1;
        }
    } else {
        callback->brightnessBurstCount = 1;
        callback->currentBurstWriteCount = 1;
        callback->lastBrightnessIntervalMs = 0;
    }

    if (callback->currentBurstWriteCount >
        callback->maxBurstWriteCount) {
        callback->maxBurstWriteCount =
            callback->currentBurstWriteCount;
    }

    callback->lastBrightnessWriteNs = nowNs;

    callback->lastBrightnessDelta =
        request >= previous
            ? request - previous
            : previous - request;

    callback->lastBrightnessRequest = request;
    callback->currentBrightness = request;

    if (callback->maxBrightness != 0 &&
        callback->currentBrightness > callback->maxBrightness) {
        callback->currentBrightness = callback->maxBrightness;
        ++callback->brightnessClampCount;
    }

    callback->currentBrightnessValid = true;

    DBGLOG(
        "radeon",
        "[BKL] write=%u burst=%u/%u dt=%ums "
        "prev=%u request=%u delta=%u current=%u "
        "ready=%d panel=%p",
        callback->brightnessWriteCount,
        callback->brightnessBurstCount,
        callback->currentBurstWriteCount,
        callback->lastBrightnessIntervalMs,
        previous,
        request,
        callback->lastBrightnessDelta,
        callback->currentBrightness,
        callback->hooksReady,
        callback->panelController);

    if (!callback->hooksReady ||
        callback->panelController == nullptr ||
        callback->orgDceDriverSetBacklight == nullptr ||
        callback->maxBrightness == 0) {
        callback->publishDiagnostics();
        DBGLOG("radeon", "brightness write recorded but PWM path is not ready");
        return result;
    }

    callback->applyCurrentBrightness("PWM write");
    return kIOReturnSuccess;
}

IOReturn RadeonBacklightPatcher::wrapFramebufferGetAttribute(
    IOService *framebuffer, IOIndex connectIndex,
    IOSelect attribute, uintptr_t *value) {

    IOReturn result = FunctionCast(
        wrapFramebufferGetAttribute,
        callback->orgFramebufferGetAttribute)(
            framebuffer, connectIndex, attribute, value);

    if (callback->hooksReady &&
        attribute == BacklightAttribute &&
        value != nullptr) {
        if (!callback->isInternalConnection(framebuffer, connectIndex)) {
            ++callback->externalBrightnessReadCount;
            callback->publishDiagnostics();
            return result;
        }
        callback->internalFramebufferRegistryId = framebuffer->getRegistryEntryID();
        ++callback->brightnessReadCount;

        // This hook is not only a cached-value accessor. AppleIntelPanelA uses
        // getAttributeForConnection('bklt') as a capability probe before it
        // calls AppleIntelPanel::setDisplay. The original WEG Navi10 patch
        // deliberately returns success here even before a meaningful cached
        // brightness exists. Requiring CurrentBrightnessValid makes the probe
        // fail, so AppleIntelPanelA exits early and never builds
        // linear-brightness. Keep state validity separate from capability.
        if (callback->currentBrightnessValid) {
            *value = callback->currentBrightness;
        } else if (result != kIOReturnSuccess) {
            *value = 0;
            ++callback->brightnessCapabilityFallbackCount;
        }

        DBGLOG("radeon",
               "bklt read #%u original=0x%x valid=%d value=0x%llx fallback=%u",
               callback->brightnessReadCount,
               result,
               callback->currentBrightnessValid,
               static_cast<uint64_t>(*value),
               callback->brightnessCapabilityFallbackCount);

        result = kIOReturnSuccess;
        callback->publishDiagnostics();
    }

    return result;
}
