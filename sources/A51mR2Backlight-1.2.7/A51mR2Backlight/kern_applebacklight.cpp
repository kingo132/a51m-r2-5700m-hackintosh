//
//  kern_applebacklight.cpp
//  A51mR2Backlight
//

#include <Headers/kern_api.hpp>
#include <Headers/kern_iokit.hpp>
#include <IOKit/graphics/IODisplay.h>

#include "kern_applebacklight.hpp"
#include "kern_applebacklight_data.hpp"
#include "kern_diagnostics.hpp"

namespace {

const char *pathBacklight[] {
    "/System/Library/Extensions/AppleBacklight.kext/Contents/MacOS/AppleBacklight"
};

const char *pathMccsControl[] {
    "/System/Library/Extensions/AppleMCCSControl.kext/Contents/MacOS/AppleMCCSControl"
};

KernelPatcher::KextInfo kextBacklight {
    "com.apple.driver.AppleBacklight",
    pathBacklight,
    arrsize(pathBacklight),
    {true},
    {},
    KernelPatcher::KextInfo::Unloaded
};

KernelPatcher::KextInfo kextMccsControl {
    "com.apple.driver.AppleMCCSControl",
    pathMccsControl,
    arrsize(pathMccsControl),
    {true},
    {},
    KernelPatcher::KextInfo::Unloaded
};

bool profileMatches(OSDictionary *panels,
                    const A51BacklightData::ApplePanelProfile &profile) {
    if (panels == nullptr)
        return false;

    auto existing = OSDynamicCast(OSData, panels->getObject(profile.name));
    if (existing == nullptr || existing->getLength() != sizeof(profile.data))
        return false;

    return memcmp(existing->getBytesNoCopy(), profile.data, sizeof(profile.data)) == 0;
}

} // namespace

AppleBacklightPatcher *AppleBacklightPatcher::callback {nullptr};

void AppleBacklightPatcher::registerKexts() {
    callback = this;

    fixedBrightnessSteps = checkKernelArgument("-a51bklfixed16");

    experimentalPanelProfile = checkKernelArgument("-a51bklprofile");

    A51Diagnostics::setBool(
        "ExperimentalPanelProfile",
        experimentalPanelProfile);

    lilu.onKextLoad(&kextBacklight);
    lilu.onKextLoadForce(&kextMccsControl);
}

bool AppleBacklightPatcher::processKext(KernelPatcher &patcher, size_t index,
                                        mach_vm_address_t address, size_t size) {
    if (kextBacklight.loadIndex == index) {
        patchAppleBacklight(patcher, index, address, size);
        return true;
    }

    if (kextMccsControl.loadIndex == index) {
        patchMccsControl(patcher, index, address, size);
        return true;
    }

    return false;
}

void AppleBacklightPatcher::patchAppleBacklight(KernelPatcher &patcher, size_t index,
                                                mach_vm_address_t address, size_t size) {
    SYSLOG("apple", "processing AppleBacklight");

    KernelPatcher::RouteRequest request(
        "__ZN15AppleIntelPanel10setDisplayEP9IODisplay",
        wrapApplePanelSetDisplay,
        orgApplePanelSetDisplay);

    if (!patcher.routeMultiple(index, &request, 1, address, size)) {
        SYSLOG("apple", "failed to route AppleIntelPanel::setDisplay");
        patcher.clearError();
        return;
    }


    if (fixedBrightnessSteps) {
        KernelPatcher::RouteRequest brightnessRequest(
            "__ZN16AppleIntelPanelA12doIntegerSetEP12OSDictionaryPK8OSSymbolj",
            wrapApplePanelDoIntegerSet,
            orgApplePanelDoIntegerSet);

        if (!patcher.routeMultiple(
                index, &brightnessRequest, 1, address, size)) {
            SYSLOG("apple",
                   "failed to route AppleIntelPanelA::doIntegerSet; "
                   "fixed brightness steps disabled");
            patcher.clearError();
            fixedBrightnessSteps = false;
            fixedBrightnessHookReady = false;
        } else {
            fixedBrightnessHookReady = true;
            SYSLOG("apple",
                   "fixed 16-step logical brightness hook ready");
        }
    }

    const uint8_t find[] = {"F%uT%04x"};
    const uint8_t replace[] = {"F%uTxxxx"};
    KernelPatcher::LookupPatch panelIdPatch {
        &kextBacklight,
        find,
        replace,
        sizeof(find),
        1
    };

    patcher.applyLookupPatch(&panelIdPatch);
    if (patcher.getError() != KernelPatcher::Error::NoError) {
        SYSLOG("apple", "failed to patch AppleBacklight panel-id format (%d)",
               patcher.getError());
        patcher.clearError();
        return;
    }

    appleBacklightHooksReady = true;
    publishDiagnostics();
    SYSLOG("apple", "AppleBacklight hooks ready");
}

void AppleBacklightPatcher::patchMccsControl(KernelPatcher &patcher, size_t index,
                                             mach_vm_address_t address, size_t size) {
    KernelPatcher::RouteRequest requests[] {
        {"__ZN25AppleMCCSControlGibraltar5probeEP9IOServicePi", wrapFunctionReturnZero},
        {"__ZN21AppleMCCSControlCello5probeEP9IOServicePi", wrapFunctionReturnZero},
    };

    if (!patcher.routeMultiple(index, requests, address, size)) {
        SYSLOG("apple", "failed to disable AppleMCCSControl probes");
        patcher.clearError();
        return;
    }

    mccsSuppressionReady = true;
    publishDiagnostics();
    SYSLOG("apple", "AppleMCCSControl probes disabled");
}

bool AppleBacklightPatcher::ensurePanelProfiles(IOService *panelService) {
    auto panels = panelService
        ? OSDynamicCast(OSDictionary, panelService->getProperty("ApplePanels"))
        : nullptr;

    if (panels == nullptr) {
        panelProfilesReady = false;
        publishDiagnostics();
        DBGLOG("apple", "ApplePanels dictionary is unavailable; will retry");
        return false;
    }

    bool allProfilesMatch = true;
    for (const auto &profile : A51BacklightData::ApplePanelProfiles) {
        const auto &effectiveProfile =
            experimentalPanelProfile &&
            strcmp(profile.name, "F19Txxxx") == 0
                ? A51BacklightData::ExperimentalF19Profile
                : profile;

        if (!profileMatches(panels, effectiveProfile)) {
            allProfilesMatch = false;
            break;
        }
    }

    if (allProfilesMatch) {
        panelProfilesReady = true;
        publishDiagnostics();
        return true;
    }

    auto rawCopy = panels->copyCollection();
    auto copiedPanels = OSDynamicCast(OSDictionary, rawCopy);
    if (copiedPanels == nullptr) {
        if (rawCopy != nullptr)
            rawCopy->release();

        panelProfilesReady = false;
        publishDiagnostics();
        SYSLOG("apple", "failed to copy ApplePanels dictionary; will retry");
        return false;
    }

    size_t repairedProfiles {0};
    bool allocationFailure {false};

    for (const auto &profile : A51BacklightData::ApplePanelProfiles) {
        const auto &effectiveProfile =
            experimentalPanelProfile &&
            strcmp(profile.name, "F19Txxxx") == 0
                ? A51BacklightData::ExperimentalF19Profile
                : profile;

        if (profileMatches(copiedPanels, effectiveProfile))
            continue;

        auto data = OSData::withBytes(
            effectiveProfile.data,
            sizeof(effectiveProfile.data));

        if (data == nullptr) {
            allocationFailure = true;
            SYSLOG("apple", "failed to allocate panel profile %s",
                   effectiveProfile.name);
            continue;
        }

        copiedPanels->setObject(effectiveProfile.name, data);
        ++repairedProfiles;

        // Match WhateverGreen's AppleBacklight ownership behaviour. Current
        // AppleBacklight keeps these profile objects alive through ApplePanels.
    }

    bool installed = false;
    if (!allocationFailure)
        installed = panelService->setProperty("ApplePanels", copiedPanels);

    if (rawCopy != nullptr)
        rawCopy->release();

    panelProfilesReady = installed;
    if (installed) {
        ++panelProfileRepairCount;
        SYSLOG("apple",
               "ensured AppleBacklight panel profiles (%lu repaired, mode=%s)",
               repairedProfiles,
               experimentalPanelProfile ? "a51-experimental" : "default");
    } else {
        SYSLOG("apple", "panel profile installation incomplete; will retry");
    }

    publishDiagnostics();
    return installed;
}

void AppleBacklightPatcher::publishDiagnostics() {
    A51Diagnostics::setBool("AppleBacklightHooksReady", appleBacklightHooksReady);
    A51Diagnostics::setBool("MCCSSuppressionReady", mccsSuppressionReady);
    A51Diagnostics::setBool("PanelProfilesReady", panelProfilesReady);
    A51Diagnostics::setBool(
        "ExperimentalPanelProfile",
        experimentalPanelProfile);
    A51Diagnostics::setUInt32("PanelSetDisplayCount", panelSetDisplayCount);
    A51Diagnostics::setUInt32("PanelProfileRepairCount", panelProfileRepairCount);

    A51Diagnostics::setBool(
        "FixedBrightnessSteps",
        fixedBrightnessSteps);
    A51Diagnostics::setBool(
        "FixedBrightnessHookReady",
        fixedBrightnessHookReady);
    A51Diagnostics::setUInt32(
        "LogicalBrightnessWriteCount",
        logicalBrightnessWriteCount);
    A51Diagnostics::setUInt32(
        "LogicalBrightnessSnapCount",
        logicalBrightnessSnapCount);
    A51Diagnostics::setUInt32(
        "LastLogicalBrightnessRequest",
        lastLogicalBrightnessRequest);
    A51Diagnostics::setUInt32(
        "LastLogicalBrightnessSnapped",
        lastLogicalBrightnessSnapped);
}

bool AppleBacklightPatcher::wrapApplePanelSetDisplay(IOService *that, IODisplay *display) {
    ++callback->panelSetDisplayCount;
    callback->ensurePanelProfiles(that);

    const bool result = FunctionCast(
        wrapApplePanelSetDisplay,
        callback->orgApplePanelSetDisplay)(that, display);

    callback->publishDiagnostics();

    if (callback->panelSetDisplayCount == 1) {
        SYSLOG("apple", "panel display set returned %d", result);
    } else {
        DBGLOG("apple", "panel display set #%u returned %d",
               callback->panelSetDisplayCount, result);
    }

    return result;
}


IOReturn AppleBacklightPatcher::wrapApplePanelDoIntegerSet(
    IOService *that,
    OSDictionary *parameters,
    const OSSymbol *key,
    uint32_t value) {

    auto self = callback;

    if (self == nullptr || self->orgApplePanelDoIntegerSet == 0) {
        return kIOReturnUnsupported;
    }

    uint32_t forwardedValue = value;

    const char *keyName =
        key != nullptr ? key->getCStringNoCopy() : nullptr;

    if (self->fixedBrightnessSteps &&
        keyName != nullptr &&
        strcmp(keyName, "brightness") == 0) {

        ++self->logicalBrightnessWriteCount;
        self->lastLogicalBrightnessRequest = value;

        constexpr uint32_t LogicalMax = 1024;
        constexpr uint32_t LogicalStep = 64;

        if (value == 0) {
            forwardedValue = 0;
        } else if (value >= LogicalMax) {
            forwardedValue = LogicalMax;
        } else {
            forwardedValue =
                ((value + LogicalStep / 2) / LogicalStep) * LogicalStep;

            if (forwardedValue > LogicalMax)
                forwardedValue = LogicalMax;
        }

        self->lastLogicalBrightnessSnapped = forwardedValue;

        if (forwardedValue != value)
            ++self->logicalBrightnessSnapCount;

        DBGLOG(
            "apple",
            "logical brightness #%u request=%u snapped=%u",
            self->logicalBrightnessWriteCount,
            value,
            forwardedValue);

        self->publishDiagnostics();
    }

    return FunctionCast(
        wrapApplePanelDoIntegerSet,
        self->orgApplePanelDoIntegerSet)(
            that,
            parameters,
            key,
            forwardedValue);
}

size_t AppleBacklightPatcher::wrapFunctionReturnZero() {
    return 0;
}
