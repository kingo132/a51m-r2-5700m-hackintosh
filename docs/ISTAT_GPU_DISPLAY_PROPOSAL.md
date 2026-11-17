# iStat GPU temperature display cleanup — proposal

Historical proposal: this priority was subsequently declined. No temperature
cleanup is scheduled or claimed complete; see [the active backlog](../TODO.md).

Status: proposed for review, not applied. This is a small monitoring-display
improvement, not a repair for typing latency, desktop stalls or GPU timeouts.

## Existing evidence

The reported menu displays the named RX 5700M temperature alongside generic
Graphics temperature rows. In the local SMCRadeonSensors source, the native
telemetry registration path exports TGxD, TGxP, TGxd, TGxp and, for card zero,
TGDD using the same RGPUTempValue reader. These aliases do not themselves
provide independent junction, memory or proximity measurements.

Source aliases establish why duplicates are possible. They do not establish
the identity of every row currently displayed by iStat; do not hide a row
solely because it has the same number or a generic name.

## Exact proposed change

1. Privately back up/export the existing iStat settings and record the current
   sensor filter. Keep configuration and any license data out of Git.
2. Match the candidate generic Graphics rows to the plugin's same-source
   temperature aliases. If identity cannot be established, leave the row alone.
3. Use iStat's own Hide Sensor control to hide only confirmed redundant
   temperature rows, retaining one clearly identified RX 5700M temperature.
   Record the exact UI-generated filter IDs before and after. Existing local
   evidence identifies the preference entry as Sensors.Menu.Filtering; do not
   invent IDs or replace the whole filter with guessed values.
4. Preserve CPU/core/SSD temperatures, actual Dell fan readings, GPU power,
   GPU core clock and VRAM clock. The two GPU clock rows are different metrics,
   not duplicate measurements. Do not change fan control or unhide previously
   hidden invalid fan rows.

No KEXT, EFI, BIOS, app binary, background service or system security change is
part of this proposal. Do not remove compatibility SMC aliases from the driver.
Do not promise arbitrary sensor renaming without established app support.

## Acceptance and rollback

Acceptance is the actual sensor menu showing one retained GPU temperature,
with distinct readings preserved and invalid fan rows still hidden. Verify the
saved filter change contains only the intended new entries. If the candidate
rows are already hidden, there is no new repair to apply or count.

Rollback removes only the newly added hide entries using the app's own controls;
do not reset every sensor filter or overwrite unrelated settings. Retain the
private export for recovery if needed. Persistence uses ordinary iStat user
settings and its supported export/import workflow; no custom reapplication
service is needed. A clean OS reinstall needs the settings backup restored;
retention across every future app version is not guaranteed.

## Scope boundary

The prior invalid fan-row hiding is existing work and is not repeated or
recounted here. No new stall root cause has been established by this proposal.
Approval is still required before changing the live menu configuration.
