# Dell sensor activity-counter repair (loaded; symptom acceptance pending)

Historical checkpoint: references below to uncommitted work describe the
original local investigation. The current release includes the a51m1 sensor
binary and source snapshot; see [release notes](RELEASE.md). Publication does
not establish that historical desktop stalls were caused or fixed by this race.

The original SMCDellSensors1.3.7 contains a checked-load/unconditional-decrement
race between audio/Bluetooth completions and the nine-ms reset timer. One
actor can test1, another clear it to0, then the first subtracts0 toUINT32_MAX.
The current installed timer instructions reproduced that interleaving in
owned memory. Official1.3.7/1.3.8 sensor sources are identical; inspected
upstream master still contains the unchecked decrements.

The local VirtualSMC-A51m fork replaces the reset loop with atomic exchange
and all nine completion decrements with saturating CAS. Concurrent tests of
the real helpers and the full Release build pass, with no new undefined
kernel imports. Fan commands, sensor poll period and original callbacks
remain unchanged. Canonical source and full evidence limits are in that
fork's `Docs/SMCDellActivity.md`; all work remains uncommitted for review.

After the user's 2026-11-15 reboot, the live kernel loads UUID
`59405B15-1B92-3A85-A63E-A7C9A4DC4C49`, and runtime properties confirm
`A51mActivityGateRevision=1.3.8-a51m1` and `ActivityCounterUnderflowFix=true`.
This accepts the deployment/startup only. Real playback/Bluetooth, fan display and long
uptime must be accepted before calling the desktop symptom fixed. This
logical race has not been linked to a specific past AMD or WindowServer
failure, and the new battery telemetry is a separate change.

Full EFI backups and an on-EFI UEFI Shell rollback exist. The default recovery
script restores the last accepted battery/config and original Dell sensor
bundle files; no extra boot entry, hot unload, restart, cache clear, BIOS
change or background recovery service was introduced.

Upstream reference: https://github.com/acidanthera/VirtualSMC/blob/1.3.7/Sensors/SMCDellSensors/kern_hooks.cpp
