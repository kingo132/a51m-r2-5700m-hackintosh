# Changelog

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
