# Maintenance release: 2026.11.15-oclp-free

The Area-51m R2 / RX 5700M EFI supports macOS 26.7.1 (25G241) with
EFI-injected Wi-Fi and audio on the original Apple system volume. Read
[migration/rollback](OCLP_FREE.md) before using it with a previously
root-patched installation. No additional boot manager is required.

The component table below describes `EFI/`, the Broadcom BCM94352Z reference.
`EFI-Intel/` is a separate macOS 26.7.3 folder for an Intel Wi-Fi 6 AX201
(`8086:06F0`, subsystem `1A56:1652`) and Intel Bluetooth `8087:0026`. See the
[Intel Wi-Fi folder](../README.md#intel-wi-fi-folder) note. Do not treat the
Broadcom rows as the contents of `EFI-Intel/`.

This is an identity-free template. Supply your own PlatformInfo locally.
The public template omits the battery observer and restores only the previous
public zero/absent Bluetooth-controller state; it never exports private identity.
Other live reference hardware settings are preserved.

**Firmware prerequisite:** AppleXcpmCfgLock=false requires CFG Lock to be
disabled in firmware. Set the quirk to true if the setting is locked or unknown.
Firmware offsets are BIOS-version-specific. SIP and SecureBootModel policies
are unchanged by this release.

## Packaged components and provenance

| Component | Packaged version | Acceptance/source |
| --- | --- | --- |
| OpenCore main application | 1.0.8 | Official Release; reference boot passed. |
| OpenRuntime, OpenCanopy, AudioDxe, OpenShell | From OpenCore 1.0.8 | Updated matching components; disabled OpenLinuxBoot is also from this package. |
| BOOTx64 fallback bootstrap | Retained prior 1.0.7 bootstrap | Exact existing reference file, not described as a new 1.0.8 bootstrap. Firmware can also launch OpenCore.efi directly. |
| Lilu | 1.7.2 | Preserved. |
| WhateverGreen | Official 1.7.1 | Replaces the old custom backlight fork; applbkl=0 and the independent backlight plugin remain. Reference boot/basic use passed. |
| VirtualSMC / SMCProcessor | 1.3.8 | Official Release; custom battery/Dell plugins are preserved rather than overwritten with stock plugins. |
| AirportBrcmFixup | 2.2.1 | Official Release; Wi-Fi traffic passed with SimpleBCM. |
| LucyRTL8125Ethernet | 1.2.4 / Info.plist 1.2.400 | Official Release; corrects promiscuous-mode handling after wake. |
| SimpleBCM | 1.2.0 | Official Release; loaded with native Skywalk/IO80211 and actual Wi-Fi traffic checked. |
| SimpleHDA | 1.0.1 | Official Release; internal audio integration. No optional HAL installed. |
| A51mR2Backlight | 1.2.7 | Retained deployed binary/source under sources/A51mR2Backlight-1.2.7. |
| SMCBatteryManager | 1.3.8-a51m7 | Retained deployed artifact and source overlay under sources/VirtualSMC-A51m-a51m7; native attached supply rating agrees with Dell reports. |
| SMCDellSensors | 1.3.8-a51m1 activity gate | Retained deployed custom binary/source overlay; not the stock same-version release. |
| SMCRadeonSensors | 2.4.0 / A51m a51m2 | Deployed telemetry artifact; source retained under sources/SMCRadeonSensors-A51m-a51m2 with its license. Basic telemetry only, not fan control or full lifecycle acceptance. |
| AppleALC / NaviAudioFixup | Custom 1.9.8 / 1.0.0 | Retain machine-specific audio/wake behavior. Do not substitute stock AppleALC solely because its version number is newer. |
| VoodooRMI | 1.3.5 | Intentionally retained; the earlier 1.4.3 Tahoe panic report is not resolved by this release. |
| NVMeFix | Disabled | Native power-management choice; a causal link to the reported rare panic was never established. |

`release-manifest.json` records all EFI/source file hashes and the official
package download hashes. The source overlays retain corresponding local source
state and licenses; matching a deployed artifact to a retained local build does
not prove complete reproducibility with another toolchain. Older battery commit
references describe the older a51m1 artifact, not the new a51m7 binary.

## Acceptance limits

See [VERIFICATION.md](VERIFICATION.md). Speakers, brightness and basic sleep/wake
are covered by the platform integration checks. Remaining
WindowServer timeouts and resolution persistence are not declared repaired.
Prior captures already show the same display mode, so a regression introduced
by this update is unproven. Adapter ratings are not instantaneous power draws;
unsupported cell metadata is not a physical measurement. See
[BATTERY_FIELDS.md](BATTERY_FIELDS.md) and [TODO.md](../TODO.md).

## Supported local application settings

These are separate from the EFI and are not applied by downloading this repo:

- AirPlay: the retained `scripts/repair_airplay_scaling.py` performs a
  build-checked one-key preference backup/restore. Run preflight again after
  an OS change. Earlier peer-Mac acceptance does not establish new OTA or
  permanent VPN endpoint compatibility.
- AlienFX: preserve lighting while disabling keyboard-triggered click suppression.
- Monitoring: iStat Menus configuration, licenses, layouts and
  preference exports stay private. Extended-uptime acceptance remains separate.
- BetterDisplay/widget mitigations are not a cure for all desktop stalls;
  consult the historical changelog and remaining-work list rather than
  automatically resetting display modes or installing a resident watchdog.

## Checks before publication/deployment

Run `python3 scripts/check_release.py`, the privacy rejection tests and the
OpenCore 1.0.8 `ocvalidate` against the sanitized config. Back up your full private
EFI and review the actual diff. Never copy a public blank-identity template over
a personalized configuration without retaining its own identity.
No publication check reboots, writes firmware, changes SIP or deploys to EFI.
