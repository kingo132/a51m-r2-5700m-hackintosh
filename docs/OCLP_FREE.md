# OCLP-free installation and recovery

This EFI supplies Broadcom Wi-Fi and onboard audio on the original macOS Tahoe
system volume. It replaces the legacy OCLP root-patch configuration; it does
not revert an existing system patch merely by being copied to the EFI partition.

## Driver configuration

- Wi-Fi: use native IOSkywalkFamily/IO80211Family with Lilu, AirportBrcmFixup,
  SimpleBCM and the AirPortBrcmNIC_Injector from AirportBrcmFixup, in that order.
- Audio: retain the machine-specific AppleALC and NaviAudioFixup. Load SimpleHDA
  after AppleALC and keep DisableLinkeditJettison enabled.
- Exclude the separate legacy IOSkywalkFamily/IO80211Family injection, its
  AirPortBrcmNIC, the IOSkywalkFamily block, AMFIPass and `-amfipassbeta`.
- Retain RestrictEvents + `revpatch=sbvmm`, existing SIP policy and
  SecureBootModel=Disabled. No iBridged or additional boot manager is required.
- Use A51mR2Backlight for internal brightness with `applbkl=0`.

Upstream documentation: [SimpleBCM](https://github.com/laobamac/SimpleBCM/tree/v1.2.0)
and [SimpleHDA](https://github.com/laobamac/SimpleHDA/tree/v1.0.1).

## Fresh installation

1. Back up the existing EFI and supply the machine's own SMBIOS identity.
2. Confirm the firmware requirements in [README.md](../README.md), including
   CFG Lock. Validate the configuration using OpenCore 1.0.8 ocvalidate.
3. Install an unmodified supported macOS system and boot through
   `\EFI\OC\OpenCore.efi`. Do not apply legacy Broadcom or AppleHDA root patches.

## Migration from an existing root-patched system

1. Preserve the complete working EFI, a data backup and a usable recovery path.
   Record the system snapshot associated with the old configuration privately.
2. Prepare the new EFI separately. A firmware/F12 entry can point directly to
   its OpenCore.efi; an additional directory does not create an entry by itself.
   Keep LauncherOption disabled when managing those entries through firmware.
3. Revert the installed root patches through the patcher's supported recovery
   mechanism. Verify that the retained original Apple snapshot matches the
   installed OS build. If explicit snapshot selection is required, verify the
   selected snapshot before proceeding.
4. Restart using the new EFI with the original system snapshot. Do not combine
   SimpleHDA with another AppleHDA restoration, or remove signature-compatibility
   components while still booting a patched IO80211 framework.
5. Verify system startup, wireless traffic, audio, brightness, battery,
   Bluetooth and sleep/wake before making the new EFI the default.
6. Remove the obsolete patcher application, helper and automatic-patching
   services. Keep recovery copies outside the active EFI directory.

If the matching original system snapshot is unavailable, use a supported system
reinstallation/recovery procedure with a verified data backup. Do not substitute
an unrelated snapshot or assume that removing the patcher application restores
the system volume.

## Rollback

Restore a **matching EFI and system state**. An old root-patch-dependent EFI
with a clean system is not equivalent to the previous installation. Conversely,
a patched system with the new AMFIPass-free configuration can fail framework
signature validation during startup.

Where the old system snapshot is retained, select that specific snapshot using
the supported administrator/recovery procedure and restore its matching EFI.
Snapshot UUIDs are machine-specific and must not be copied from another system.
An alternate directory on the same EFI partition cannot recover a failed disk
or a destroyed partition; retain an independent recovery route.

## Updates and peripheral compatibility

Keep the system volume original and update the EFI components as required for
the target macOS version. New OS releases, Continuity integrations and peripheral
combinations must be assessed against their hardware and software requirements.
This release does not establish compatibility beyond the documented platform.
