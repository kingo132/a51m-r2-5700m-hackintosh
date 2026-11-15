# Changelog

## 2026.11.15 — OCLP-free Tahoe release

### Wi-Fi and audio

- Replace legacy IOSkywalkFamily/IO80211Family injection with SimpleBCM 1.2.0
  and the system's native networking stack.
- Add SimpleHDA 1.0.1 alongside the machine-specific AppleALC.
- Remove AMFIPass, its boot argument and the IOSkywalkFamily block.
- Preserve NaviAudioFixup, Bluetooth firmware support and RestrictEvents/sbvmm.

### Updated components

- OpenCore main application, OpenRuntime, OpenCanopy, AudioDxe and OpenShell: 1.0.8.
- WhateverGreen: official 1.7.1; standalone backlight support remains enabled.
- VirtualSMC and SMCProcessor: 1.3.8.
- AirportBrcmFixup: 2.2.1.
- LucyRTL8125Ethernet: 1.2.4, including the upstream post-wake promiscuous-mode fix.
- Preserve the compatible fallback bootstrap and document its provenance.

### Platform integration

- A51mR2Backlight 1.2.7: internal-panel TG/cache handling and PWM-state consistency.
- SMCBatteryManager a51m7: battery-state policy, adapter-rating bridge and
  validated per-input firmware reporting.
- SMCDellSensors: activity-counter handling.
- SMCRadeonSensors: A51m Navi telemetry integration.
- Set AppleXcpmCfgLock=false for firmware configured with CFG Lock disabled.
  Installations with locked/unknown firmware must keep the quirk enabled.

### Packaging and documentation

- Include public source snapshots, licenses and artifact checksums.
- Exclude machine identities and diagnostic captures from the public EFI.
- Document original-system migration and matching EFI/system rollback.
- Correct the obsolete OCLP requirement, unconditional Thunderbolt support
  statement and unproven NVMeFix-panic attribution.
- Preserve documented display/lifecycle limitations; do not substitute guessed
  battery measurements or introduce a resident recovery service.

## 2026.10.11

- Disable redundant PS/2 mouse/trackpad plugins and unused Linux boot drivers.
- Retain VoodooI2C/VoodooRMI for the trackpad and PS/2 keyboard support.
- Add firmware-specific CFG Lock setup tools.
- Integrate the machine-specific AppleALC wake recovery and NaviAudioFixup.
- Disable NVMeFix for the native NVMe configuration; subsequent evidence did
  not establish the earlier suspected panic attribution.

## 2026.09.18

- Move internal-panel brightness support into A51mR2Backlight.
- Disable duplicate WhateverGreen backlight handling with applbkl=0.
- Add Tahoe support.

Earlier implementation history is retained in Git history. Current installation
requirements are defined in [README.md](README.md) and [release notes](docs/RELEASE.md).
