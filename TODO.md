# Current migration checkpoint

Reconciled 2026-11-16: the upstream reference-machine checks below are retained
as recorded acceptance, not a fresh live-system test in this merge. The local
HDMI 1.2.15 checkpoint is separate from the packaged backlight 1.2.7. Earlier
preparation/staging statements describe their own checkpoints; remaining
brightness-import proposals and lifecycle tests are not completed repairs.
See [release verification](docs/VERIFICATION.md) for the published scope.

- OCLP-free reference boot, Wi-Fi network access, speakers, brightness and
  basic sleep/wake passed; OCLP-Mod is removed and the matching original Apple
  system snapshot is active. This does not close the broader lifecycle tasks.
- The current reference battery build is a51m7: its native 480 W attached
  supply rating agrees with validated 240 + 240 W reports. Earlier BAT-00
  placeholder descriptions below are historical and need remaining consumer,
  plug/unplug and lifecycle acceptance rather than another fixed-value patch.
- The profile includes Ethernet 1.2.4. AppleXcpmCfgLock=false requires
  CFG Lock to be disabled in firmware; keep the quirk enabled otherwise.
- Display resolution persistence remains open. Earlier captures show the
  same 1280x720 logical / 2560x1440 pixel, 60 Hz mode, so introduction by this
  update is unproven. Do not add a periodic forced-resolution service.
- Validate AirDrop, Handoff, Watch unlock, HDMI/headphone audio, SD card and
  OTA behavior separately before expanding the compatibility claims.

# Repair backlog

## Queue discipline and current scope, 2026-11-15

User scope update, 2026-11-15: **skip issues reliably confirmed to affect
genuine Macs with the same failure under comparable conditions.** Do not
develop or deploy a Hackintosh-specific repair for those shared issues.
Keep them recorded as skipped, not fixed, with the comparison evidence.
Shared Apple code, a generic macOS report, or unspecified reporter hardware
alone is insufficient; label such cases comparison pending. Continue the
existing queue with Hackintosh-specific failures. NET-01 controller-rule
deployment is paused pending this classification and user review; no rule
has been applied. Do not uninstall ZeroTier based on this scope change.

The backlog is **not complete**. The user's latest instruction is to prioritize
unresolved user-visible failures, not repeatedly accept already-deployed fixes.
The active repair queue below supersedes the old difficulty/acceptance inventory
later in this file. Work on one failure at a time; preserve the genuine-Mac
skip rule and show a concrete plan before live changes. Current healthy samples
are not closure of historical failures, and diagnostic messages alone are not
new user-visible defects. Do not silently substitute another investigation.

## Active repair priorities, 2026-11-15

Latest user correction: **difficulty/readiness first, not severity alone.**
The previous UC-03-first dispatch conflated work impact with repair difficulty.
UC-03 is high-impact but high-difficulty, with no proven production repair;
it must not monopolize the ready-repair queue through repeated short captures.
The BLE-loss/45-second-withdrawal evidence is retained, not marked repaired.

Ready-to-apply repairs at this checkpoint: **none newly established** among the
remaining active failures. Do not invent an easy task, treat routine acceptance
as a new repair, or relabel an unresolved root cause as low difficulty. Review
existing evidence for a specific supported change, review/rollback/acceptance
criteria, then present that concrete change to the user before applying it.

Keep urgency and difficulty separate. Rank an actionable, demonstrated repair
ahead of exploratory reverse engineering; within comparable readiness prefer
the smaller, reversible intervention. Root-cause-unknown items stay research
items with provisional/unknown difficulty. Deferred cosmetics, untouched
accounts, user-managed BIOS and confirmed shared-Mac exclusions remain outside
the immediate execution queue. No new experiment or live change follows from
this scheduling correction.

Historical scope note: UC-01 is skipped from custom repair under the
user's genuine-Mac shared-symptom rule: first-person reports identify an iMac
and M1 MacBook Air with unreliable wake reconnects. Those reports do not prove
the same internal 15-second timeout mechanism; this is a scope decision, not
root-cause equivalence or repair completion. Evidence is retained in the
backlight project's `Docs/UNIVERSAL_CONTROL.md`. No UC patch was installed.

BKL-01 review correction: do not implement the proposed current-raw RAM
snapshot/replay as an approved repair. The user has not approved it and asks
for native genuine-Mac alignment first. The approved display-only test reproduced
logical drift, but a saved native value corresponding to the original 75%
is not proven corrupt. Temporary raw values are not user intent. Preserve the
Apple storage mechanism; establish the bridge's specific contract/lifecycle
defect before proposing production changes. Details are at the top of the
backlight project's `Docs/BRIGHTNESS_RESUME.md`.

### Difficulty-first queue: proposed work, not completed repairs

Latest user dispatch: skip MON-02 display cleanup; work on BKL-01 first.
HDMI audio and HDMI DDC/CI failures are added as DISP-02 / DISP-03 for source
and upstream-issue review. Local preparation is authorized overnight; live
deployment and reboot remain excluded pending review. No iStat changes follow.

The local BKL-01 proposal now isolates the native logical-target import store.
The retained 104-value XR ramp and four critical wake values match native-code
replay; 76 conditional policy/native-import cases also pass with explicitly
supplied eligibility. A live eligibility source and modern loader remain
unimplemented. A 57-case lifecycle/source model now rejects failed imports, recycled
instances, nested scopes, dynamic linear writes, preset resets and unknown
writes without caching a brightness number; actual native
event observations and concurrency integration remain absent. A separate
kernel-only current-value-retention model fails when two rebuilds have no EDR
commit between them, so waiting for a frame is not accepted as a repair.
Genuine-iMac MCCS/GPUB comparison rules out simply switching
metadata as a proven repair. See the backlight project's
`Docs/BRIGHTNESS_IMPORT_REPAIR_20261116.md` and
`Docs/BRIGHTNESS_NATIVE_MCCS_20261116.md` before any
implementation/deployment decision. HDMI source findings and the inactive-link
acceptance gap are recorded in [the HDMI audit](docs/HDMI_AUDIO_DDC.md).

Additional native MCCS roundtrip cases show that its self-generated linear
writes publish canonical, linear and usable values through the native event
path; flag `+0x52c` does not retain a separate logical user target. A transient
receiver for existing CoreBrightness reason/commit notifications was also
started with a deadline at the scheduled review, after exact native ABI/code
checks and eight owned local-dispatch cases. Four subsequent real notifications
confirmed delivery, with two commit/state pairs. This does not identify the
caller or observe all target writes; subscriptions were removed at the deadline. Native shared
headroom and the non-probing logical getter can be read without an administrator;
26 native cases establish that published headroom cannot unconditionally be
inverted into private scale. These are research tools and code candidates,
not installed repair components or a verified root cause for new live events.

The genuine-iMac attribute comparison was corrected: its backlight type is
nested in `IODisplayAttributes`, and Apple's native info builder flattens that
dictionary. Seven owned native merge cases verify the semantics; absence of a
direct registry key must not be called a legacy-path proof. The newer native
IOBacklight wrapper also reads current parameter values; merely enabling its
x86-disabled switch is not an established wake repair. Neither route was enabled.

Difficulty estimates are provisional, particularly where the fault has not
been reproduced or attributed. This order does not imply that a supported
patch exists for each item. No additional sampling, live setting changes or
EFI deployment was performed to prepare this reorder.

| Order | ID | Estimated difficulty | Remaining work and readiness |
| --- | --- | --- | --- |
| Deferred | MON-02 | Low; user declined this priority | Duplicate GPU-temperature display cleanup is not being pursued. No live iStat filter change was made. Retain [the unused proposal](docs/ISTAT_GPU_DISPLAY_PROPOSAL.md) only as history. |
| 2 | APP-01 | Medium–high, uncertain | Long-conversation typing/scroll/click stalls. The retained normal-period layout trace does not prove the reported fault. No specific production change is established. Apply the comparable genuine-Mac skip rule before custom repair. |
| First by user dispatch | BKL-01 | High | Native replay matches the recorded XR ramp and target drift through physical restore, scale cleanup and logical import. Conditional import preservation is tested on owned objects; live eligibility, loader and acceptance remain incomplete. Native MCCS/GPUB requires real-panel compatibility and curve/persistence adaptation and does not alone prove prevention. No deployment or new persistence mechanism. |
| 4 | UC-03 | High–very high | Recurrent peer-pointer lag/crossing failures. BLE presence loss precedes a 45-second availability withdrawal even with transport still open. Receiver/filter/peer attribution remains incomplete; opening Bluetooth settings is not a permanent repair. No UC patch deployed. |
| 5 | WS-01 | Very high | Desktop/window stalls with software-fence timeouts. Some events have long-held ControlCenter handles; other events remain unattributed. No proven safe change to the blocking path. Do not increase timeout thresholds or suppress logs as a repair. |
| 6 | GPU-01 | Very high; deepest unresolved evidence gap | Historical AMD completion timeout / Metal crash. Final hardware completion and raw interrupt evidence are missing. No speculative IRQ/power patch or polling workaround. Healthy current operation does not close this item. |

MON-02 was only a monitoring-display proposal and was declined as a priority.
It must not be reported as a new stutter, driver or hardware fix.
APP-01 through GPU-01 remain unresolved; difficulty order is not a promise of
completion time or permission to apply an unproved change.

### Deferred, restricted and evidence-dependent items

| ID | Difficulty / disposition | Remaining limitation |
| --- | --- | --- |
| BAT-02 | Unknown; monitor pending recurrence | Historical 31 A current excursion remains unexplained; present raw/driver readings agree. Do not clamp current or repeatedly capture healthy operation. |
| FW-01 | Unknown; user-managed BIOS | Automatic SupportAssist diagnostics trigger is unproved. Do not infer failed macOS shutdown from the scan alone. No BIOS write is authorized. |
| ACC-01 | Unknown; account changes restricted | Contacts validation retries are unattributed. Accounts and databases remain untouched. |
| DISP-02 | Connected-session audio passed; monitor lifecycle | Current HDMI port2/node3 metadata is correct, the native stereo output is selected, and the user heard playback. Existing NaviAudioFixup retained; no AudioFixup migration justified by this session. Hotplug/wake audio and historical failure attribution remain open. |
| DISP-03 | Fixed for current connected HDMI/app readback; lifecycle checks remain | Loaded1.2.15 UUID/EFI hashes match. User screenshot shows all four DDC statuses green. Independent BetterDisplay brightness/contrast reads and full415-byte capabilities return success;17 attributable valid replies,0 bus/frame errors or pass-through. No agent settings/SetVCP change. Retain backups and uncommitted source. Physical miniDP regression, HDMI reconnect/hotplug, sleep/wake, long uptime and periodic-read configuration/behavior remain separate unchecked boundaries. |
| NET-01 | Unknown; policy work paused | AirPlay/ZeroTier selection and missing receiver return route have recovery evidence, not a permanent fix. Comparable genuine-Mac classification and review remain required; no controller rule applied. |
| BKL-02 | Deferred by user | Brightness HUD endpoint/step presentation. Backend maximum is reachable; display cosmetics do not take priority over functional failures. |
| UC-02 | Very high; enhancement deferred | Ethernet-first transport with AWDL fallback. Independent transport tests are not actual system policy/authentication/reconnect acceptance; no patch deployed. |
| UC-01 | Skipped custom repair under shared-Mac policy | Genuine-Mac wake reconnect symptoms were reported first-hand; this does not establish equivalence to the local 15-second timeout. Not permanently fixed. |

Monitor outside the execution queue: UI-01 world-clock removal is a mitigation,
not an Apple callback-lifetime repair; MON-01 iStat 7 and already-hidden invalid
fan rows are not new work; BAT-00/BAT-01 battery metadata, SMI-01 activity-counter
repair, DSP-01 display-policy mapping and the AOACWake repair retain lifecycle
acceptance limits. HID-01 shutdown wait has low demonstrated impact; CHR-01
host_statistics has no demonstrated causal link to stalls. Do not repeatedly
sample healthy operation or count acceptance as a new repair.

HID-01 (shutdown report completion wait) is **monitor / low demonstrated impact**,
not an active kernel-patch project. One retained shutdown report samples one
second of WindowServer waiting for a userspace HID SetReport completion. Exact
symbolication does not support the earlier attribution to a VoodooInput lock;
the accompanying Bluetooth touchpad teardown is a candidate. No complete wait
duration, daily-work impact, firmware-diagnostics causation or same-version
genuine-Mac comparison has been established. Shared Apple code does not prove
that genuine Macs exhibit the same symptom. If genuine-Mac comparison shows
normal bounded behavior without user impact, do not pursue a custom patch.
Escalation requires repeatable material impact, target attribution and user
review; no HID repair has been installed.

The verified battery source was published to VirtualSMC's existing
[`a51m-battery-telemetry` branch](https://github.com/kingo132/VirtualSMC/tree/a51m-battery-telemetry)
in commit [`ff8d8cb`](https://github.com/kingo132/VirtualSMC/commit/ff8d8cb17b5d062194bad7cb5dfd66aec6253672),
with explicit remaining acceptance limits. This
does not mark the entire battery category or the remaining system backlog done.
Raw captures, device identities and EFI configuration remain private.

Current post-boot acceptance, 2026-11-15: battery a51m7 UUID
742CD514-F5D5-3307-BA43-625F9F968DEE is actually loaded. Native AppleSmartBattery
publishes 480 W; fresh validated WMAX input readings are 240 + 240 W with
stable count 2 and repeated successful minute polls. Cycle count remains 21.
This is rated supply capacity, not measured wall power. Firmware status 2
indicates capacity below the platform's expected requirement; do not fake it
normal or infer per-port electrical limits. Real iStat menu inspection timed
out; its Power settings preview is sample data. Plug/wake acceptance is open.

AirPlay network recovery, 2026-11-15: the receiver had its correct ZeroTier
address and service listener but no kernel route for the managed private
subnet. Replies fell through its ordinary LAN gateway. The user-approved
one-network managed-address refresh restored the route while retaining all
original flags and membership. SSH/AirPlay ports changed from two-second
timeouts to about five milliseconds. Thirteen samples over three minutes all
passed. This is recovery, not a permanent ZeroTier/macOS route fix or a new
real mirroring-session acceptance. No VPN was disabled or controller rule set
changed, and no watchdog service was installed.

Read-only normal-use checkpoint, 2026-11-15: UI-01 and MON-01 have a healthy
60-second sample at about one hour uptime (NotificationCenter 0.182% CPU,
iStat 7.50 Menubar 0.812%). Symbolized heap inspection found zero instances
of the historically identified 48-byte SurfacePool callback. The approved
removed desktop clock remains absent; other clock widgets were not changed.
Long-uptime and genuine-Mac comparison remain pending, with no active patch
justified by this sample. Existing battery/Dell markers and current 240 +
240 W telemetry pass; displaypolicyd has another startup checkpoint without
the old assertion. See [bounded acceptance and remaining limits](docs/UI_MON_ACCEPTANCE_20261115.md).
These items are not closed; continue the numbered queue rather than repeatedly
sampling a healthy minute or treating normal uptime as proof of repair.

A dated normal-use 60-second window trace: 143 new software fences all
resolved, no timeout/pairing error/open handle. ControlCenter max hold about
48 ms and iStat about 11 ms. Kernel tracing state before/after is identical.
Earlier boot and intermittent timeouts remain open; a healthy sample cannot
prove a permanent repair or acceptance of later boots. The registered WindowServer diagnostic-state port
also failed as root (KERN_FAILURE 5), so no state request was sent and that
entry is no longer being retried. No system protection was changed.

The AOACWake missing-RMDT abort repair passed isolated control-flow and
post-boot checks; complete sleep/wake acceptance remains pending. The new
SMCDellSensors activity-counter repair is now loaded and its runtime markers
are confirmed. Playback/Bluetooth/uptime acceptance and linkage to historical
desktop stalls remain unproven. Both fixes must not be counted as completed
brightness, AMD-fence or Universal Control repairs.

Independent full EFI backups and the on-EFI UEFI Shell rollback remain
available. A fresh verified backup of this boot-accepted configuration also
exists privately. At that local checkpoint, the published maintenance release was unchanged;
the upstream OCLP-free packaging is recorded separately above. The first RX 5700M extension loaded but failed feature acceptance because the
kernel property was a serialized callback object. Corrected a51m2 is boot-verified for basic telemetry; it restores upstream temperature reads
and moves statistics work off SMC traps. The two invalid native fan rows are
now hidden in the live iStat menu using its own hide action; saved raw keys and
fresh menu inspection confirm this. This is not an overnight system repair. No automatic restart was requested.

## Historical difficulty and acceptance inventory

The former numbering below is retained for traceability, not active dispatch.
Use the active repair priorities above. Difficulty is provisional. Completed
fixes are in
[CHANGELOG.md](CHANGELOG.md).

| Order | ID | Difficulty | User impact | Open item and acceptance target |
| --- | --- | --- | --- | --- |
| 1 | NET-01 | Low–medium | High | Permanently fix the receiver ZeroTier missing-return-route condition or provide a supported selection policy. One-network recovery currently restores reachability; Repeated fresh sessions must use a reachable local endpoint and disconnect cleanly with the VPN running. |
| 2 | UI-01 | Low–medium | Medium | Validate the notification-center/world-clock mitigation over extended uptime. Confirm callback counts and CPU/memory stay bounded; distinguish widget removal from an upstream drawing-lifetime fix. |
| 2a | MON-01 | Low–medium | Medium | Validate the purchased iStat Menus 7 upgrade with the restored layout and Stats removed. Check real sensor/menu behavior and bounded CPU/window callbacks over extended uptime; do not attribute version 6 findings to version 7 without new evidence. Keep license and settings backups private. |
| 2b | BAT-00 | Low–medium, provisional | Medium | Synthetic 60 W/16 V fields were removed and a51m7 live adapter/dual-input ratings now pass. Finish safe plug/wake and real UI acceptance for remaining metadata; Verify actual firmware data availability and per-command unknown/unsupported consumer behavior before changing the ABI. Never substitute guessed watts or cell voltages. See [field audit](docs/BATTERY_FIELDS.md). |
| 2c | SMI-01 | Low–medium | Potentially high | The SMCDellSensors activity-counter repair is loaded with its fix/revision markers confirmed. Pre-repair timer/completion instructions reproduce a zero-to-UINT32_MAX race in owned memory; source CAS/reset repair and concurrent tests pass. Playback/Bluetooth/fan/uptime acceptance and linkage to historical stalls remain pending. See [activity-latch repair](docs/SMI_ACTIVITY.md). |
| 3 | DSP-01 | Medium | High | Finish displaypolicyd/Built-In-map lifecycle acceptance: repeated boots, mode changes, external-display changes and sleep/wake, without identity-transition aborts or TG regressions. |
| 4 | ACC-01 | Medium | Low | Identify which account-validation requests trigger Contacts retries. Determine the caller and supported correction; do not delete system accounts or databases without review. |
| 5 | BAT-01 | Medium | Medium | Live cycle count 21, temperature, native 480 W total and validated 240 + 240 W input reports pass. Complete remaining identity/capacity/health, application and plug/wake acceptance. Preserve working ACPI capacity/current units; unsupported strings/voltage/current must not be invented. |
| 6 | APP-01 | Medium–high | High | Capture actual typing/scrolling/clicking stalls in a long conversation. Correlate input events, layout work, compositor waits and server dispatch; normal-period forced-layout samples alone are insufficient. |
| 7 | BAT-02 | High | Medium | Explain the historical 31 A battery-current excursion. Match the same raw source sequence and virtual-SMBus request at preparation/completion with the system value. Do not infer a current fix from the corrected time overflow or clamp current. |
| 8 | UC-01 | High | Critical | Permanently repair peer-Mac Universal Control reconnect failure. An authenticated inbound connection can become Ready while another discovery request times out after 15 seconds and cancels it. Verify destination-metadata handoff, same-device matching, pending-request attachment and timer cancellation. Repeated sleep/wake reconnects must work without restarting ensemble or adding a watchdog. |
| 9 | BKL-01 | High | High | Preserve the user's actual internal brightness across display rebind/wake. Observe replacement AppleBacklightDisplay objects and later EDR writes; fix the responsible target/state handoff, not a periodic brightness reset. Test both logical target and panel parameters and restore the original setting after each test. |
| 10 | WS-01 | High | High | Resolve the remaining WindowServer software-fence timeouts. Correlate each fence with live client handles and display-reconfiguration/server-lock timing. Earlier ControlCenter attribution applies only to its captured events; later untraced events must be attributed separately. |
| 11 | GPU-01 | Very high | High | Explain old AMD completion delays/Metal failures. Obtain or otherwise discriminate the final hardware fence and raw interrupt-ring stage during a real failure. Do not label software stamps, ordinary resource-residency delays or polling workarounds as proof of missing hardware interrupts. Include long-uptime VRAM growth/release measurements before claiming a leak. |
| 12 | UC-02 | Very high | High | Implement real Ethernet-first Universal Control with authenticated same-peer selection and native AWDL fallback. Component-level wired tests passed, but the system policy is not deployed. Validate cross-Mac authentication, interface/address changes, loss/recovery of Ethernet and sleep/wake without reducing system protection. |
| 12a | FW-01 | Medium, provisional | Medium | Determine why BIOS enters SupportAssist pre-boot diagnostics intermittently. Distinguish hardware/POST-triggered diagnostics from OS Recovery boot-failure threshold; the photo alone does not establish a trigger. Read current firmware events/settings before proposing a BIOS change; do not reuse old-version offsets. |
| Deferred | BKL-02 | Medium, provisional | Cosmetic | Synchronize the existing brightness HUD with actual maximum/step values. Keep deferred by user choice. Backend full-scale success is not on-screen acceptance; require synchronized screen/value capture. |
| Monitor | HID-01 | High, provisional | Low demonstrated impact | Attribute the shutdown SetReport completion wait and measure actual delay before considering any patch. Compare equivalent genuine-Mac behavior if available. No VoodooRMI/VoodooInput lock cause or installable fix is established; keep behind the existing queue. |
| Monitor | CHR-01 | Undetermined | Unproven | Chrome host_statistics warnings: no demonstrated buffer-size defect or causal link to stutter. Escalate only with correlated failure evidence; no speculative EFI/browser patch. |

- [ ] NET-01: permanent reachable AirPlay endpoint selection.
- [ ] UI-01: extended-uptime widget mitigation acceptance.
- [ ] MON-01: iStat Menus 7 layout and uptime acceptance.
- [ ] BAT-00: accurate handling of unavailable adapter/cell metadata.
- [ ] SMI-01: staged Dell sensor activity-counter repair acceptance.
- [ ] DSP-01: display-policy lifecycle acceptance.
- [ ] ACC-01: supported correction for Contacts retries.
- [ ] BAT-01: trustworthy battery metadata.
- [ ] APP-01: actual long-conversation input-stall attribution and repair.
- [ ] BAT-02: historical 31 A current attribution.
- [ ] UC-01: permanent peer-Mac reconnect repair.
- [ ] BKL-01: actual wake brightness preservation.
- [ ] WS-01: remaining software-fence timeout repair.
- [ ] GPU-01: AMD completion/Metal fault attribution and repair.
- [ ] UC-02: authenticated Ethernet-first policy with AWDL fallback.
- [ ] FW-01: intermittent automatic firmware diagnostics trigger.
- [ ] BKL-02: deferred HUD synchronization.
- [ ] HID-01: monitor shutdown report-completion wait; no patch work ahead of existing queue.
- [ ] CHR-01: monitor only; establish impact before changing behavior.

## Rules for implementation

- Show the concrete repair plan before changing the live machine. Back up the
  exact component and retain a tested rollback.
- No reboot, cache clearing, BIOS changes or unrelated code commits without
  authorization. Publishing this maintenance update is separately authorized.
- Do not install custom resident recovery services or weaken system protection.
- Keep firmware reports, normalized driver state, virtual-bus replies and
  physical hardware evidence distinct. A passing isolated test is not a
  cross-Mac or sleep/wake acceptance result.
- Publish anonymized findings only. Never include serial-derived hostnames,
  SMBIOS identifiers, ROM/MAC identity, account identifiers or raw captures.
- Manual shutdown and the configured charging thresholds are not defects.
