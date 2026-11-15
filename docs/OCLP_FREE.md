# OCLP-free Tahoe: installation, acceptance and rollback

The current reference is an Intel A51m R2 / RX 5700M on macOS 26.7.1
(25G241). SimpleBCM 1.2.0 and SimpleHDA 1.0.1 were boot-checked on the matching
original Apple system snapshot. This is not a guarantee for every OS update,
Broadcom card or Continuity feature.

## What changed

- Wi-Fi: remove separate legacy IOSkywalkFamily, IO80211FamilyLegacy and its
  AirPortBrcmNIC injection; remove the native IOSkywalk block. Use the system's
  native IOSkywalkFamily/IO80211Family with SimpleBCM.
- Preserve dependency order: Lilu, AirportBrcmFixup, SimpleBCM, then the
  AirPortBrcmNIC_Injector inside AirportBrcmFixup.
- Audio: keep the machine-specific AppleALC and NaviAudioFixup; put SimpleHDA
  after AppleALC. Keep DisableLinkeditJettison enabled. The optional SimpleHDA
  HAL package was not installed on the validated reference.
- Remove AMFIPass and `-amfipassbeta` only as part of the clean-system switch.
- Keep RestrictEvents + `revpatch=sbvmm`, existing SIP settings and
  SecureBootModel=Disabled. Do not infer full security-policy restoration.
- No iBridged, NootRX, alternative boot manager or periodic recovery daemon
  is added. Independent A51mR2Backlight remains responsible for brightness.

Sources: [SimpleBCM](https://github.com/laobamac/SimpleBCM/tree/v1.2.0),
[SimpleHDA](https://github.com/laobamac/SimpleHDA/tree/v1.0.1), and
[the owner's issue discussion](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6899475502).
The commenter later reverted iBridged in their Python-framebuffer setup;
that setup is not silently copied into the reference EFI.

## Existing root-patched installation

1. Back up the whole personalized EFI locally, the current working system
   snapshot identity and the matching old configuration. Keep a boot/recovery
   route that does not depend on the new configuration.
2. Prepare the injector-based candidate in `EFI/OC.test`; give it its own
   direct firmware/F12 entry targeting `\EFI\OC.test\OpenCore.efi`. Disable
   LauncherOption for both entries so they do not rewrite the chosen firmware
   order. A second folder alone does not create an F12 entry.
3. Revert the old system root patches before first starting the new candidate.
   The reference used the installed patcher's documented APFS rollback
   mechanism: inspect the retained Apple snapshot read-only, verify the same
   OS build, select the last sealed snapshot, and explicitly select/verify
   that original snapshot when necessary. The current running system does
   not change until the next boot.
4. Only after the original snapshot is selected, boot the paired candidate.
   Simply uninstalling the patcher application does **not** undo its system
   patches. Do not enable SimpleHDA on top of another AppleHDA restoration.
5. Confirm the actual running snapshot and loaded drivers. Test Wi-Fi network
   traffic, audio, brightness, battery, Bluetooth and sleep/wake. Then promote
   the accepted candidate to `EFI/OC`, fix LauncherPath for that directory,
   compare all files, and move the redundant test copy to local backup.
6. Remove obsolete patcher app/helper/automatic-patching services. Retain
   private backups, not identity-bearing copies in this public repository.

The reference initially booted the clean-system configuration while the old
patched system was still selected. `applekeystored` could not load the patched
IO80211 framework under the restored signature rules, causing a panic. The
paired snapshot/configuration transition above is essential.

If the original matching snapshot cannot be verified, do not guess or remove
signature compatibility blindly. A supported reinstall over the existing
system, with a verified data backup, is a separate recovery path.

## Fresh installations and future updates

Use the personalized injector EFI with an unmodified supported macOS system;
do not apply the old Wi-Fi/audio root patches. A subsequent OTA update was
not performed during this acceptance, so OTA, Watch unlock, AirDrop, Handoff,
headphone/HDMI audio and other untested functions remain separate checks.
Future macOS versions may require injector updates or fresh compatibility work.

## Rollback must match the system state

An old root-patch-dependent EFI and a clean original system are not the same
pair as the previous working installation. Restoring only the EFI does not
restore a patched system snapshot; selecting a patched snapshot with the new
AMFIPass-free configuration can reproduce the signature failure.

Retain both the old EFI and its matching system-snapshot identity privately.
Where the old snapshot still exists, select that specific snapshot using the
supported recovery/administrator procedure and boot the matching old EFI.
Do not publish a reference machine's snapshot UUID or copy it onto another
machine. Verify that snapshot retention and a recovery path actually exist;
a second directory on the same EFI partition cannot recover a destroyed
partition or failed disk.

The deployed reference now keeps only `EFI/OC`; firmware entries pointing at
removed test directories should be removed or repointed locally. No new boot
manager is required.
