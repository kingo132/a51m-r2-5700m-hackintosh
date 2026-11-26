# Changelog

## 2026-11-26 — Intel AX201 folder

- Add `EFI-Intel/` beside the Broadcom `EFI/`. Tested on an Area-51m R2
  (i9-10850K, RX 5700M) with macOS 26.7.3 (25G342) and SMBIOS iMac20,2.
- Wi-Fi is Intel AX201 (`8086:06F0`, subsystem `1A56:1652`) through
  AirportItlwm 2.4.0. Bluetooth is Intel USB `8087:0026` through
  IntelBluetoothFirmware 2.5.3, IntelBTPatcher 2.5.3 and BlueToolFixup 2.7.2.
- AirportItlwm and SimpleHDA in this folder load only on Darwin 25.0.0–25.99.99.
  Platform serial, MLB, ROM and UUID are blank. Windows boot files and Dell
  diagnostic logs are not included. The Broadcom `EFI/` is unchanged.

## Reconciled work scope — 2026-11-16

The published EFI retains A51mR2Backlight 1.2.7; the local HDMI 1.2.10–1.2.15
entries below describe separate development/deployment checkpoints, not binaries
included in this release. Earlier staged/pending entries are historical steps;
the 1.2.15 connected-session acceptance does not close lifecycle testing.
The original SMCBatteryManager 1.3.8-a51m1 time/state repair is retained as
history; the current packaged battery revision is a51m7.

The upstream OCLP-free checkpoint records limited reference-machine acceptance
with SimpleBCM/SimpleHDA. Migration instructions are not completed actions on
another installation, nor was the live EFI or system changed by this merge.
Official component versions and the retained older fallback bootstrap are
listed in [release notes](docs/RELEASE.md); broader acceptance stays open.
TobiiBridge's separate repository link remains in [README](README.md).

## Unreleased — scoped HDMI response wait1.2.15 (connected app readback accepted)

- Implement reviewed10ms native minimum for qualified synchronous HDMI reads,
  retaining larger waits and restoring original caller metadata. Preserve
  native DAL sequencing/errors, DP/eDP behavior and existing guards.
- Add28 core restoration and28 owned-native sequencing/exclusion cases.
  Existing protocol/concurrency suites and isolated Release/Debug/binary
  checks pass. After user approval, verify complete local EFI/ESP incremental
  rollback and all290 active payloads; replace only this KEXT executable/Info.
  Config, app settings and other drivers unchanged. User controls restart;
  After user restart, verify actual BetterDisplay brightness/contrast and
  complete415-byte capabilities, with17 attributable valid replies and0
  bus/frame errors. User screenshot confirms all four DDC checks pass.
  Physical miniDP/reconnect/wake/long-uptime acceptance remains separate.


## Unreleased — actual HDMI1.2.14 transport acceptance (app still open)

- Verify real kernel Type2 reads for six controls and complete capabilities
  with37/38-byte caller capacities at correct10ms waits. This is physical
  acceptance of the shared-buffer/reader path, not complete app acceptance.
- Isolate a current BetterDisplay service-name timing conversion mismatch.
  Its configured10ms is not converted for this ATY service name; short-delay
  physical requests fail while millisecond waits succeed. Prepare an unapplied
  scoped native minimum-wait proposal. No new KEXT/EFI/app setting change.


## Unreleased — shared-buffer HDMI repair1.2.14 (staged)

- Implement reviewed pre-send command retention with reply-stage descriptor
  revalidation; preserve strict scope ownership, native send/wait/preclear,
  type2, errors and DP/eDP exclusions. Shared-buffer and negative regression
  suites plus isolated Release/Debug/binary checks pass.
- After user approval, verify fresh complete local EFI/ESP incremental rollback
  and all290 active payloads. Replace only the backlight executable/Info;
  config/other drivers unchanged. User controls restart. Actual new kernel
  Type2, BetterDisplay and miniDP acceptance remain pending.


## Unreleased — HDMI shared-buffer failure (diagnosed, repair proposed)

- Boot-check1.2.13: physical HDMI qualification succeeds, but the reply-stage
  classifier rereads the shared send/reply buffer after native DAL preclear.
  The command is erased; real app requests still fall through without repair.
- Reproduce all29 shared-buffer cases with the unchanged classifier; a local
  retained-command prototype passes29 and rejects28 descriptor/snapshot
  negatives. Its two-file source diff is unapplied. No new KEXT/EFI, config,
  other-driver, service or restart change is performed. Actual repair remains
  open pending review and live kernel/App/miniDP acceptance.

## Unreleased — observed HDMI signal and capabilities correction (historical staging)

- Boot-check1.2.12: code/ABI admission and TG hooks pass, but actual HDMI
  requests remain rejected by the wrong signal constant16; the observed
  native HDMI value is4. Withdraw the synthetic fixture assumption.
- Prepare1.2.13 with independent signal/RGB regression and bounded standard
  GetVCP/capabilities replies. Real Simple-transport replies validate the
  production parser and native capacity clamp, not new live kernel hooks.
  Candidate builds and owned native tests pass. After explicit user review,
  stage only this KEXT executable/Info after verified full local EFI and ESP
  incremental rollback. All290 files checked: config/other drivers unchanged.
  No automatic restart or completed live DDC repair is claimed.


## Unreleased — metadata-only framebuffer update compatibility

- Diagnose a confirmed26.7.3 identity change rejecting unchanged native code
  in the1.2.11 HDMI/TG guards. Prepare a local1.2.12 candidate that admits
  complete supported code/layout contracts independently of UUID, retaining
  header, function digest, symbol and actual-device/interface checks.
- Strengthen TG admission to full native routines while preserving baseline
  behavior.53 compatibility cases, native fixtures and Release/Debug pass.
  Stage the reviewed candidate with verified full local/ESP incremental
  rollback, changing only the backlight bundle and preserving config/other
  payloads. No restart/live-success claim; arbitrary future private driver
  changes still require compatibility work.

## Unreleased — HDMI post-boot integration correction

- Record1.2.10 as loaded but ineffective: actual HDMI queries never passed
  qualification. Correct AmdLink/dc_link object handoff and scope the native
  selected link/engine in the isolated1.2.11 build; add full native-entry
  tests rather than supplying successful eligibility.
- Stage the KEXT-only follow-up with verified full local and incremental ESP
  rollback. Preserve config and other payloads. User restart and real HDMI/
  miniDP acceptance remain pending; capabilities enumeration is still open.

## Unreleased — local HDMI type-2 driver candidate

- Stage the isolated HDMI-only build on the archived 1.2.7 brightness/TG
  baseline after explicit deployment approval and two verified full EFI
  backups. Replace only the backlight bundle and append its enable argument;
  retain all other drivers/configuration. Await user restart and actual
  readback/miniDP acceptance; do not claim the loaded system is repaired.
- Implement a default-off fixed GetVCP type-2 reply repair in the local
  A51mR2Backlight source. Preserve type 2 and native DAL sequencing; reuse the
  native byte reader for one correctly addressed reply and validate its frame.
  Scope it to authenticated RX 5700M HDMI brightness, volume and mute queries;
  keep miniDP/eDP/MST and other commands native.
- Release build and owned native-code/core tests pass. The isolated candidate
  is staged in EFI; loaded candidate, boot/app readback and physical miniDP
  regression are not yet established.
  Keep source uncommitted for review and private evidence outside the repository.

## Unreleased — connected HDMI configuration repair

- Enable DDC only for the connected HDMI monitor in BetterDisplay after a
  configuration backup. Its DDC setting was disabled. Normal app brightness
  control passed a physical 38 -> 39 -> 38 test, with three checksum-valid
  independent reads at every stage. No EFI/KEXT, volume, mode, service or
  system restart change was needed.
- Confirm HDMI audio playback under the existing NaviAudioFixup configuration
  with actual user confirmation. No new audio patch was applied.
- Keep native DDC/CI type-2 read compatibility open: Simple reads return valid
  values on the same HDMI connection, but app direct readback still fails.
  Automatic synchronization and reconnect/wake are not claimed complete.
  Raw identities and configuration backups remain private.

## Unreleased — local sensor updates

- Radeon a51m2 is boot-verified for basic temperature, power, frequency and
  cached telemetry. The invalid native GPU fan rows are hidden using iStat's
  settings; hardware fan control is unchanged. Full wake/uptime acceptance is
  separate from this basic telemetry check.
- Correct the A51m battery a51m6 native adapter bridge in a51m7: use the fresh
  attached total from Dell selector 3, with selector-6 AC/PSID validation.
  The previous static 330 W export was not correct for two attached 240 W
  supplies. No fixed wattage or rated voltage/current pair is fabricated.
- Add opt-in A51m R2 WMAX read-only per-input rated-power telemetry. Publish a
  validated pair only after stable two-input counts and agreement with the
  exact fresh total snapshot. Ambiguous single-input/invalid/stale results
  remain unavailable. No new daemon or GPU/charger control is introduced.
- iStat receives the single total rating; independent port ratings are exposed
  by the driver cache and local diagnostic reader, not two claimed iStat rows.
- a51m7 is now boot-verified: correct loaded UUID/revision, native 480 W total
  and fresh validated 240 + 240 W reports from the attached pair. Only the
  battery executable changed within OC after two full verified backups. Real
  iStat UI, plug/unplug and wake acceptance remain open. All changes
  remain local and uncommitted for SourceTree review.


### Subsequent local recovery and acceptance

- Recover one peer Mac's missing ZeroTier return route using the existing
  client's approved managed-address refresh. Preserve all four flags and
  membership; add no service. SSH/AirPlay ports now connect in about 5 ms,
  with 13 route/port checks passing over three minutes. Permanent macOS/ZeroTier
  route compatibility and an actual new mirroring-session check remain open.
- A normal-use 60-second trace resolves all 143 new software fences without
  timeout or open handles; tracing state is restored exactly. This is a healthy
  baseline, not a claim that prior wake/uptime stalls are repaired.

## 2026-11-15 — OCLP-free EFI and corrected acceptance scope

- Replace separate legacy Skywalk/IO80211 Wi-Fi injection and AMFIPass with
  SimpleBCM 1.2.0; remove the IOSkywalk block and `-amfipassbeta`.
- Add SimpleHDA 1.0.1 after the preserved custom AppleALC. On the reference
  machine, revert to the matching original Apple snapshot and uninstall
  OCLP-Mod application/services; checking out this repository does neither.
- Update OpenCore main application, its matching OpenRuntime/OpenCanopy/
  AudioDxe/OpenShell components, official WEG, VirtualSMC/SMCProcessor and
  AirportBrcmFixup. The existing fallback BOOTx64 bootstrap is retained and
  separately identified; do not describe it as a new 1.0.8 binary.
- Retain and package deployed SMCBatteryManager a51m7, SMCDellSensors a51m1
  and SMCRadeonSensors a51m2 with source snapshots and artifact checksums.
  Earlier documentation describing fixed 60 W/16 V fields applies to the
  earlier battery build, not the current adapter-rating bridge.
- Update LucyRTL8125Ethernet to 1.2.4 (Info.plist 1.2.400), including
  the upstream correction for promiscuous-mode handling after wake.
- Set AppleXcpmCfgLock=false for firmware with CFG Lock disabled. Keep the
  quirk enabled on installations with locked or unknown firmware.
- Preserve SIP and RestrictEvents/sbvmm; omit iBridged, extra boot managers
  and redundant test configurations. The publication template clears identity
  and Bluetooth controller state and disables the diagnostic battery observer.
- Correct the Broadcom/Ventura advice, overly broad Thunderbolt statement
  and unproven NVMeFix-panic attribution. Preserve existing unresolved display,
  long-uptime, Continuity and calibration limitations.


## 2026-11-15 — Tahoe display and battery maintenance

This update packages fixes already deployed on the reference A51m R2. It does
not claim that every sleep/wake or desktop-stutter problem is resolved.

### EFI fixes

- Update A51mR2Backlight from 1.2.1 to the deployed 1.2.7 Release binary.
  Dynamically populate the internal display's TG cache from its native active
  stream, invalidate owned state on mode changes, and retain native valid
  values. No hardcoded TG number is introduced. Subsequent checks found the
  internal native/cache values consistent and the former invalid-TG warning
  absent.
- Preserve U16.16 PWM precision, restrict Radeon backlight overrides to the
  built-in panel, synchronize AMD's stored backlight registers after PWM
  writes, and return the native post-restore value after panel initialization.
  These address driver-level consistency defects; wake brightness drift and
  the on-screen brightness indicator remain separate open issues.
- Replace `CFG_LINK_FIXED_MAP` with `CFG_LINK_BUILT_IN_MAP` on the existing
  dGPU path. This avoids the early synthetic/late real display-identity
  transition implicated in displaypolicyd's startup abort. The abort did not
  recur in subsequent boot checks; full lifecycle acceptance remains open.
- Update SMCBatteryManager from 1.3.7 to the A51m-specific 1.3.8 build. This
  includes upstream polling/notification fixes and the opt-in A51m time policy:
  inappropriate states, invalid/zero rates and out-of-range estimates return
  the standard unknown time rather than overflowing into plausible values.
  Valid discharge estimates remain available; current is not clamped.
- Enable `-a51mbattime` in the public profile. Keep `-a51mbatobserve` OFF by
  default; it remains available for bounded fault investigation. The local
  diagnostic machine may keep observation enabled independently.

### System and application fixes documented for reinstallation

- AirPlay: disable root-scope `wirelessdisplay_enable_vtscaling` using a
  framework-version-checked, one-key backup/restore tool. This avoids the
  reproduced input-padding/AMD encoder-pool failure. Two actual peer-Mac
  connect/disconnect cycles passed. It does not fix VPN endpoint selection.
- Shottr: disable AlienFX's keyboard-triggered mouse-click suppression while
  retaining keyboard lighting.
- The old iStat 6 menu-bar application was temporarily replaced with Stats.
  The owner subsequently chose the official iStat Menus 7 upgrade; use the
  purchased version and restore the original layout locally. Do not publish
  license codes or preference exports. This is not a claim that iStat caused
  all stutter; version 7 needs its own uptime acceptance.
- Disable BetterDisplay's F14/F15 alternative brightness keys and display
  connection management. A wake comparison improved, but later fence timeouts
  recurred; retain this as mitigation, not a complete WindowServer repair.
- Remove the world-clock widget implicated by the notification-center
  comparison. Underlying callback-lifetime defects are not claimed fixed.

### Verification and privacy

- Battery policy and observer were confirmed active after reboot. Retained
  firmware/source/virtual-SMBus/system values agree during discharge; capacity
  decreases are consistent with reported current. The previous 31 A reading
  did not recur, so its cause is still open.
- A 50% start / 80% stop BIOS charging policy explains AC-attached, not-charging
  behavior above the stop threshold. It is not a battery-driver failure.
- Audit iStat's battery fields against the registry and driver: 60 W adapter
  power and 16 V cell voltage are compatibility placeholders, not measurements.
  Cycle count and unsupported metadata remain open; see
  [battery field accuracy](docs/BATTERY_FIELDS.md).
- The reported shutdown was initiated manually and is excluded from the bug
  backlog.
- Sanitize all public PlatformInfo identity fields, including MLB and ROM;
  exclude raw diagnostic archives, firmware license tables and private logs.
  Public documentation refers only to a "peer Mac", never its serial-derived
  hostname. Removing current files does not erase prior Git history.
- Add artifact/source checksums, release checks, an English ordered backlog
  and installation/rollback notes. No new firmware settings or live system
  changes are made by publishing this repository.

See [release notes](docs/RELEASE.md), [remaining work](TODO.md), and
[privacy rules](docs/PRIVACY.md). Earlier history remains in [README](README.md#changelog).
