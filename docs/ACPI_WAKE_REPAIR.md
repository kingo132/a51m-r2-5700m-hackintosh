# ACPI device-resume repair (boot accepted; sleep/wake pending)

Historical checkpoint: the a51m4 observations and pre-publication status below
are retained as investigation history. The current release already packages
the revised AOACWake AML and battery a51m7; see [release notes](RELEASE.md).
This document does not supersede later battery telemetry or claim full wake acceptance.

After the user's reboot, the kernel table list identifies the revised `A51M
AOACWake` revision 1. The captured boot's AppleACPIPlatform records contain no
RMDT lookup or method-execution error. The local battery a51m4 is loaded, all
three battery switches are active, and the battery remains installed. This
accepts deployment/startup only; no real sleep/wake cycle was performed in
that capture.

The installed AOACWake table called `\RMDT.P1` unconditionally although its
optional debugging provider was absent. The current macOS boot log reports
`AE_NOT_FOUND` in `\_SB.PCI0.LPCB._PS0`. Executing the exact old AML in an
isolated ACPICA namespace reproduces that abort before its remaining actions.

The revised source is in `sources/ACPI/SSDT-AOACWAKE.dsl`. It has no dependency
on RMDT and does not call the system `_WAK(3)` from a device `_PS0`. System
resume remains owned by OSPM rather than being replayed on device power-up.
This follows the distinction between device power state and system resume in
the [ACPI sleeping/waking model](https://uefi.org/specs/ACPI/6.6/16_Waking_and_Sleeping.html).

A Darwin-only pending flag is set in `_PS3` and consumed once in `_PS0` before
sending `Notify(LID0, 0x80)`. Initial/repeated D0 requests do not send fake lid
wakes. Other operating systems do not receive these methods. No register
offsets, physical memory regions, EC values or charging settings are added.

Run `python3 scripts/test_acpi_wake.py` with iasl/acpiexec installed. Six
hardware-free scenarios cover initial D0, device resume, repeated D0, multiple
cycles, system `_WAK` ownership and the non-Darwin path. This validates control
flow, not actual panel wake, lid behavior or long-term stability. The firmware
device-method names are confirmed by current runtime execution; an unknown
future BIOS still requires a namespace/boot-log check before reuse.

This is not a repair for every brightness/Universal Control issue. In
particular, the old `_WAK` call never completed on the captured boot; removing
its preceding error must not silently activate a new system-wide recovery.

The companion local battery a51m4 build adds numeric-only observation of the
existing `_BIX`/`_BIF` reads. It changes no battery measurements, charging
policy or cycle-count result. A reported zero is still unverified. The old
checked-in DSDT differs in length from the current table, so its constant-zero
cycle slot and unit-switch defect must not be transplanted as live fixes.

The postboot numeric observation now confirms that current firmware `_BIX`
returns a 20-element package, unit=mAh, design=7895, full=7077 and cycle=0.
The zero is present before the KEXT's normalization or virtual-SMBus export.
Offline Windows Dell records independently show an A3CallerBattery software
SMI path for cycle queries. Thirty-eight paired historical request/reply
records returned 21, including a record dated October 2026. These are history,
not a current physical measurement; never install the cached number as a fix.
The Dell managed implementation specifies AX=0x21A3, BH=0x17, BL=battery
location, and decodes AX as the result with error sentinels. A live macOS
implementation still requires platform/interface validation, transport safety,
battery matching and error handling. No new SMI/MMIO operation was attempted.

Deployment requires a complete private EFI backup on another disk, the exact
old AML/KEXT on the EFI partition, a UEFI Shell restoration script and a
matching OpenCore config validation. Backups and personalized configs must
remain outside Git. The published release is unchanged until acceptance.
