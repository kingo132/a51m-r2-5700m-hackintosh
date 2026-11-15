//
//  kern_start.cpp
//  A51mR2Backlight
//

#include <Headers/plugin_start.hpp>
#include <Headers/kern_api.hpp>

#include "kern_backlight.hpp"

static BacklightController controller;

static const char *bootargOff[] {
    "-a51bkloff"
};

static const char *bootargDebug[] {
    "-a51bkldbg"
};

static const char *bootargBeta[] {
    "-a51bklbeta"
};

PluginConfiguration ADDPR(config) {
    xStringify(PRODUCT_NAME),
    parseModuleVersion(xStringify(MODULE_VERSION)),
    LiluAPI::AllowNormal | LiluAPI::AllowInstallerRecovery | LiluAPI::AllowSafeMode,
    bootargOff,
    arrsize(bootargOff),
    bootargDebug,
    arrsize(bootargDebug),
    bootargBeta,
    arrsize(bootargBeta),
    KernelVersion::Monterey,
    KernelVersion::Tahoe,
    []() {
        controller.init();
    }
};
