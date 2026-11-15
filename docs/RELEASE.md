# Maintenance release: 2026.11.15-oclp-free

This release provides an OpenCore EFI for the Intel Alienware Area-51m R2 /
RX 5700M on macOS Tahoe 26.7.1 (25G241). Wi-Fi and onboard audio use EFI
injection on an original Apple system volume. The package contains one OC
configuration and does not require an alternative boot manager.

Read [migration and recovery](OCLP_FREE.md) before replacing an EFI used with
system root patches. Supply your own PlatformInfo identity; this public template
omits serials, UUIDs, MLB, ROM and diagnostic battery-observer settings.

**Firmware requirement:** CFG Lock must be disabled for
`AppleXcpmCfgLock=false`. Set the quirk to true if firmware is locked or its
state is unknown. Firmware setup offsets are specific to the BIOS version.
SIP and SecureBootModel policies are unchanged by this release.

## Packaged components and provenance

| Component | Packaged version | Integration/source |
| --- | --- | --- |
| OpenCore main application | 1.0.8 | Official Release. |
| OpenRuntime, OpenCanopy, AudioDxe, OpenShell | From OpenCore 1.0.8 | Updated matching components; disabled OpenLinuxBoot is also from this package. |
| BOOTx64 fallback bootstrap | Retained prior 1.0.7 bootstrap | Compatible fallback bootstrap; firmware may also launch OpenCore.efi directly. |
| Lilu | 1.7.2 | Preserved. |
| WhateverGreen | Official 1.7.1 | Replaces the old custom backlight fork; applbkl=0 and the independent backlight plugin remain. Standalone backlight support remains enabled. |
| VirtualSMC / SMCProcessor | 1.3.8 | Official Release; custom battery/Dell plugins are preserved rather than overwritten with stock plugins. |
| AirportBrcmFixup | 2.2.1 | Official Release; paired with SimpleBCM. |
| LucyRTL8125Ethernet | 1.2.4 / Info.plist 1.2.400 | Official Release; repairs promiscuous-mode handling after wake. |
| SimpleBCM | 1.2.0 | Official Release; native Skywalk/IO80211 integration. |
| SimpleHDA | 1.0.1 | Official Release; internal audio stack. Optional HAL is not bundled. |
| A51mR2Backlight | 1.2.7 | Retained deployed binary/source under sources/A51mR2Backlight-1.2.7. |
| SMCBatteryManager | 1.3.8-a51m7 | Retained deployed artifact and source overlay under sources/VirtualSMC-A51m-a51m7; native attached supply rating agrees with Dell reports. |
| SMCDellSensors | 1.3.8-a51m1 activity gate | Retained deployed custom binary/source overlay; not the stock same-version release. |
| SMCRadeonSensors | 2.4.0 / A51m a51m2 | A51m telemetry integration; source and license under sources/SMCRadeonSensors-A51m-a51m2. Does not provide fan control. |
| AppleALC / NaviAudioFixup | Custom 1.9.8 / 1.0.0 | Retain machine-specific audio/wake behavior. Do not substitute stock AppleALC solely because its version number is newer. |
| VoodooRMI | 1.3.5 | Intentionally retained; the earlier 1.4.3 Tahoe panic report is not resolved by this release. |
| NVMeFix | Disabled | Native power-management choice; a causal link to the reported rare panic was never established. |

[release-manifest.json](../release-manifest.json) records EFI/source hashes and
upstream package checksums. Source snapshots and licenses accompany the custom
components. Build outputs can vary with the toolchain; hashes identify the
distributed artifacts.

## Compatibility and limitations

See [validation](VERIFICATION.md) for platform coverage and [the roadmap](../TODO.md)
for known display and lifecycle issues. Adapter ratings are not instantaneous
power draws; see [battery reporting](BATTERY_FIELDS.md).

Application-specific settings for AirPlay, monitoring utilities and display
management are independent of the EFI. They are not applied by downloading this
package. The AirPlay helper script provides build-checked preference backup and
restoration; review its preflight result before use after an OS change.

## Checks before publication/deployment

Run `python3 scripts/check_release.py`, the privacy rejection tests and the
OpenCore 1.0.8 `ocvalidate` against the sanitized config. Back up your full private
EFI and review the actual diff. Never copy a public blank-identity template over
a personalized configuration without preserving its own identity.
No publication check reboots, writes firmware, changes SIP or deploys to EFI.
