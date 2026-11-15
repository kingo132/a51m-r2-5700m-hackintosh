# Maintenance release: 2026.11.15

## Scope

This is a release package of the deployed display/battery fixes, with explicit
remaining limitations in [TODO.md](../TODO.md). It is not a release of the
uninstalled Universal Control, displaypolicyd code-page or brightness-HUD
candidates. The public EFI is a template and cannot carry an owner's identity.

Validated reference: Intel A51m R2, RX 5700M, macOS 26.7.1 (25G241),
OpenCore 1.0.7. Private-driver hooks fail closed for unknown fingerprints;
support for another system build requires fresh validation.

Battery metadata is not fully supported: the adapter's 60 W and cell's 16 V
are fixed compatibility values. The time fix does not repair these fields.
Read the [field accuracy audit](BATTERY_FIELDS.md) before interpreting monitor
app readings as hardware measurements.

| Component | Packaged version | Provenance |
| --- | --- | --- |
| A51mR2Backlight | 1.2.7, Release | Exact deployed binary, matching retained source snapshot under `sources/A51mR2Backlight-1.2.7`; original project: [A51mR2Backlight](https://github.com/kingo132/A51mR2Backlight). Newer development candidates are excluded. |
| SMCBatteryManager | 1.3.8, A51m revision `1.3.8-a51m1` | [VirtualSMC fork commit 05fe28585a568d61246d6b43a1d982d1ef9c6120](https://github.com/kingo132/VirtualSMC/commit/05fe28585a568d61246d6b43a1d982d1ef9c6120). |
| OpenCore and other KEXTs | Existing repository versions | Preserved from the current main branch; no unrelated upgrade. |

[`release-manifest.json`](../release-manifest.json) records the changed KEXT
files and source checksums. The backlight project file is reconstructed from
the development project with the later DPC module excluded and version pinned
to 1.2.7; implementation files are the retained deployment snapshot. A build
check is not a claim of byte-for-byte reproducibility across Xcode versions.

## EFI configuration

- Use `CFG_LINK_BUILT_IN_MAP=1` instead of `CFG_LINK_FIXED_MAP=1` on the existing
  dGPU path. Preserve all unrelated hardware properties.
- Keep `applbkl=0` so WhateverGreen does not duplicate the standalone backlight
  implementation.
- Enable `-a51mbattime` for the A51m battery time policy. The public profile
  leaves `-a51mbatobserve` absent. For fault capture only, add it temporarily,
  retain captures privately, then remove it. No observer daemon is required.
- Do not add the old `-a51bklfixed16`, `-a51bklprofile`, legacy-curve, DPC or HUD
  test flags. Native brightness targets must remain intact.
- Fill in **your own** SMBIOS identity locally before booting. The public
  template intentionally clears serials, UUIDs, MLB and ROM. Never publish
  the personalized file.

## System/application settings

These are not EFI settings and are not silently applied by checking out this
repository:

1. **AirPlay:** `scripts/repair_airplay_scaling.py --preflight` performs a
   read-only installed-framework check. After reviewing the plan, run with
   administrator privileges and `--apply`. The tool changes only root-scope
   `com.apple.coremedia/wirelessdisplay_enable_vtscaling` to false, saves the
   original two preference scopes privately, verifies with a fresh process
   and rolls back a failed application. `--restore <backup.json>` restores
   only when the current scopes still match the expected applied state.
   New sessions read the preference; no service or system restart is needed.
   A fresh OS needs reapplication; after a system upgrade, run preflight again
   and refuse unknown binaries. Framework UUIDs are software build IDs, not
   machine identifiers. VPN address selection remains an independent issue.
2. **AlienFX:** turn off keyboard-triggered accidental-click suppression;
   lighting remains available.
3. **Menu monitoring:** the owner now uses the official iStat Menus 7 upgrade,
   superseding the temporary Stats replacement. Back up/export the original
   layout locally and verify its migration. Stop Stats after iStat is working
   to avoid duplicate polling. License codes and exported preferences stay
   private. Version 7 is not assumed to inherit or fix every version 6 issue;
   validate it over extended uptime.
4. **BetterDisplay:** turn off "Allow using F14/F15 as alternative brightness
   keys" and "Enable connect/disconnect option for displays". The latter
   disables BetterDisplay soft display reconnection and its Intel wake
   workaround. It does not fix all wake brightness or fence timeouts.
5. **Widgets:** leave the implicated world-clock widget removed while
   extended-uptime behavior is validated.

For reinstall/upgrade, recheck these supported app settings rather than
installing a private always-running recovery service. App settings may migrate
with the user profile, but persistence across every future upgrade is not
guaranteed. The AirPlay key is private and requires build-specific revalidation.

## Installation and rollback

1. Back up the entire existing EFI outside the EFI partition as well as the
   individual old KEXTs/config. Preserve the private identity locally.
2. Compare the target with this release's two updated KEXTs and config deltas.
   Do not replace a personalized config blindly or copy private backups into
   this repository. Existing VirtualSMC remains unchanged by this package.
3. Run `python3 scripts/check_release.py` and an `ocvalidate` matching the
   installed OpenCore version. Review the diff before deployment.
4. Boot only when separately authorized. Verify loaded versions, TG state,
   brightness control, battery time/state and logs. Keep unresolved wake
   behavior distinct from basic boot/brightness acceptance.
5. To roll back, restore the backed-up KEXTs and matching private config
   together. Restore the AirPlay key through its typed backup, and app settings
   through their own UI. Do not clear unrelated preferences or caches.

No deployment, system restart, firmware write or automatic recovery service
is triggered by these release checks.
