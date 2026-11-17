# Normal-use acceptance checkpoint, 2026-11-15

Scope: UI-01 and MON-01 first, then the existing battery/Dell sensor and
display-policy acceptance items. Read-only; no reboot, cache clearing,
process pause/restart, preference change, EFI write or commit. No UI click,
new sleep/wake, audio playback, Bluetooth disconnection or power unplug was
performed. Private evidence is located by `ui-mon-current.txt` in the existing
private investigation directory; raw logs, preferences and registry snapshots
are not publication material.

Environment: macOS 26.7.1 (25G241), x86_64. Uptime was about one hour when
collection began. The running iStat Menus Menubar sample identifies version
7.50 (2395). Stats.app was absent from the two inspected application folders
and no corresponding process was found.

## Notification Center and iStat

Seven process samples span 60.32 seconds. CPU percentages below are derived
from process CPU-time deltas, rather than a single `ps` percentage. PIDs stayed
constant throughout; the collector did not restart processes.

| Process | Average CPU | RSS start/end |
| --- | ---: | ---: |
| NotificationCenter | 0.182% | 102.94 / 102.98 MiB |
| iStat Menus Menubar | 0.812% | 141.55 / 142.60 MiB |
| iStat Menus helper | 0.000% | 53.55 / 53.56 MiB |
| iStat daemon | 0.116% | 20.76 / 20.75 MiB |
| chronod | 0.033% | 62.12 / 62.00 MiB |
| WindowServer | 10.560% | 454.74 / 454.74 MiB |
| ControlCenter | 0.663% | 120.30 / 120.30 MiB |

Three-second, 10-ms thread samples show the NotificationCenter and iStat
main loops primarily waiting for events. They do not show the historical
layout-blocking stack during these samples. This is not an interactive-menu
or typing responsiveness test.

A successful symbolized heap pass reports 538 matching 48-byte malloc blocks
and zero instances identified as the historical `RB::SurfacePool::collect(bool)`
callback. The first noContent heap pass hid invocation names, so it cannot be
used to count that callback; the subsequent symbolized pass is the evidence.
Do not equate this narrow zero count with absence of all queued callbacks.

The approved removed desktop World Clock instance is still absent. The current
eight-instance set exactly matches the original set minus that removed
instance. Three instances occur in the stored desktop placement, none a clock;
two other configured clock instances are outside that placement. Desktop
hiding remains set in standard desktop mode. This is a stored configuration
check, not a visual layout inspection; no remaining widget was removed.

The preceding hour contains three NotificationCenter Error/Fault events and
74 iStat Menubar events. Forty-two iStat events belong to Bluetooth subsystems;
other events include scene/XPC and network messages. No iStat event message in
this selected log matches a constraints error. These observations do not prove
the messages are harmless or causal. WindowServer separately reports 1,145
`Invalid window` messages, plus fence/timeout-related messages; their client
origin and user impact remain unassigned. Do not assign them to iStat 7 based
on the old version-6 comparison or promote WS-01 ahead of the queue.

Disposition: UI-01 and MON-01 have a healthy bounded checkpoint and require no
new patch based on this sample. They remain long-uptime acceptance / genuine-Mac
comparison pending. One hour of uptime and one minute of measurements cannot
accept a symptom historically developing after one or two days. No permanent
fix or shared-genuine-Mac classification is claimed.

## Existing battery and Dell sensor repairs

- Live registry identifies SMCBatteryManager `1.3.8-a51m7`, Dell telemetry
  enabled, and synthetic SMC metadata omitted.
- Live pack values: 21 cycles, 5,861 / 7,077 mAh remaining / full-charge,
  7,895 mAh design, about 12.33 V, current 0 mA, AC attached and not charging.
  This is consistent with the previously stated 50%-start / 80%-stop policy.
  It is not a new charging-threshold or battery-health test.
- Inapplicable current time estimates are 65535 (unknown). The current bounded
  observer ring contains 64 records, no changed replies, no missing sources,
  no unpaired request phases, no dropped writes, and current values of 0 mA.
  The ring has overwritten older records as designed; the historical 31 A
  excursion is not explained by this healthy snapshot.
- Validated cached dual-adapter telemetry is active, roughly seven seconds
  old: two attached inputs, 240 + 240 W, total 480 W. The dual query reports
  330 requests, zero failures. These are supply ratings, not instantaneous
  input power or a promise of sustained platform power. Firmware status 2
  remains visible; it was not forced to normal.
- Cached Dell telemetry is active, 679 requests, zero failures; the current
  temperature report is 34.85 C. The reader itself only reads the cache and
  does not issue ACPI/SMI/MMIO requests.
- SMCDellSensors exposes `A51mActivityGateRevision=1.3.8-a51m1` and
  `ActivityCounterUnderflowFix=true`. This confirms the repair marker is
  present, not live measurement of its private activity counter or proof
  that old desktop stalls were caused by that counter race.

Disposition: current startup/readout acceptance passes within these limits.
Plug/wake, real playback/Bluetooth/fan/UI and long-uptime acceptance remain
open. No unsafe unplug or new stress test was requested.

## Display-policy startup checkpoint

The live GPU properties contain `CFG_LINK_BUILT_IN_MAP=1` and no
`CFG_LINK_FIXED_MAP` entry in the inspected PCI device registry. The preceding
75-minute selected displaypolicyd Error/Fault log has one volatile-preferences
message, without the former identity-transition assertion. Available matching
crash report files predate this boot; none is new in this startup window.

Disposition: this boot adds a successful startup checkpoint for the existing
configuration repair. Complete sleep/wake, external-display and mode-change
acceptance is still open. No display was disconnected or reconfigured here.
