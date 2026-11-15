# Alienware Area-51m R2 — macOS EFI

OpenCore configuration for the Intel Alienware Area-51m R2 with AMD Radeon
RX 5700M. This release supports macOS Tahoe 26.7.1 (25G241) with Wi-Fi and
onboard audio supplied through EFI injection, without OCLP system-volume patches.

## Release 2026.11.15

- OpenCore 1.0.8, official WhateverGreen 1.7.1, VirtualSMC 1.3.8,
  AirportBrcmFixup 2.2.1 and LucyRTL8125Ethernet 1.2.4.
- SimpleBCM 1.2.0 uses native IOSkywalkFamily/IO80211Family; SimpleHDA 1.0.1
  supplies AppleHDA support alongside the machine-specific AppleALC.
- A51mR2Backlight 1.2.7 provides internal-panel brightness control.
- A51m battery and sensor extensions provide battery-state handling,
  firmware-rated adapter reporting and Radeon telemetry.
- RestrictEvents and `revpatch=sbvmm` remain enabled. No iBridged or
  alternative boot manager is required.

See [release notes](docs/RELEASE.md), [changelog](CHANGELOG.md),
[migration and recovery](docs/OCLP_FREE.md), and [validation](docs/VERIFICATION.md).

## Before installation

1. Back up the existing EFI and retain an independent recovery route.
2. Supply your own SMBIOS identity. Serial numbers, UUIDs, MLB and ROM are
   intentionally absent from this public template; see [privacy](docs/PRIVACY.md).
3. **CFG Lock must be disabled in firmware for this profile's
   `AppleXcpmCfgLock=false`. Set the quirk to `true` if firmware remains locked
   or its state is unknown.** The quirk does not unlock firmware.
4. Use an original supported macOS system. Existing OCLP Wi-Fi/audio patches
   must be reverted before switching to this EFI; removing the OCLP application
   alone does not revert those patches.
5. Validate the personalized configuration with OpenCore 1.0.8 `ocvalidate`.
   Boot from `\EFI\OC\OpenCore.efi` using the firmware boot menu.

The existing `setup_var.efi` tools target settings documented for the matching
Area-51m R2 firmware. Offsets must be checked against the installed BIOS version;
they are not portable to other machines or firmware revisions.

## Hardware and driver notes

| Function | Configuration |
| --- | --- |
| RX 5700M graphics | Official WhateverGreen; `agdpmod=pikera` |
| Internal brightness | A51mR2Backlight; `applbkl=0` avoids duplicate WEG hooks |
| Realtek audio | Machine-specific AppleALC and SimpleHDA |
| Radeon HDMI audio | NaviAudioFixup |
| Broadcom Wi-Fi | AirportBrcmFixup, SimpleBCM and AirPortBrcmNIC_Injector |
| Bluetooth | BlueToolFixup, BrcmFirmwareData and BrcmPatchRAM3 |
| Ethernet | LucyRTL8125Ethernet 1.2.4 |
| Trackpad | VoodooI2C + VoodooRMI 1.3.5; redundant PS/2 mouse/trackpad entries disabled |
| NVMe | Native power-management configuration; NVMeFix disabled |

Retain the custom AppleALC and sensor components when updating official packages.
A matching upstream version number does not mean a custom plugin can be replaced
with the stock binary. VoodooRMI 1.3.5 is retained because the reported Tahoe
panic with 1.4.3 has not been resolved.

Thunderbolt compatibility is device-dependent. The existing `PCI-Thunderbolt`
property covers reported devices, but some Thunderbolt eGPU configurations
require an additional SSDT. An Alienware Graphics Amplifier is a different
interface; do not apply Thunderbolt eGPU changes indiscriminately.
[Device-specific discussion](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6871461373).

NVMeFix remains disabled as a configuration choice. The earlier suspected
connection to rare panics was not established: the same failure was reported
with NVMeFix disabled.
[Correction](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6392392587).

## Known limitations

Intermittent WindowServer synchronization/fence delays and display-mode
persistence after sleep remain open. Battery adapter values represent supply
ratings, not instantaneous consumption; unsupported cell measurements are not
synthesized. See [battery reporting](docs/BATTERY_FIELDS.md) and the
[maintenance roadmap](TODO.md).

Compatibility is scoped to the listed hardware and macOS build. Other panels,
peripherals, firmware revisions and later operating systems may need additional
configuration. SIP policy is unchanged by this release.

## Development and related projects

Source snapshots, licenses, component versions and SHA-256 checksums are included
in [release-manifest.json](release-manifest.json).

- [A51mR2Backlight](https://github.com/kingo132/A51mR2Backlight)
- [VirtualSMC](https://github.com/kingo132/VirtualSMC)
- [SimpleBCM](https://github.com/laobamac/SimpleBCM)
- [SimpleHDA](https://github.com/laobamac/SimpleHDA)
- [TobiiBridge](https://github.com/kingo132/TobiiBridge)
- [Panel timing and EDID guide](high-resolution-refresh-rate.md)
- [Historical Navi10 timing analysis](fix_navi10_4k_120hz.md)
