# Release verification — 2026.11.15-oclp-free

## Reference machine: performed

- Confirmed running from the retained matching original Apple 25G241 snapshot.
  The additional on-disk AppleHDA and IO80211 framework files from the patched
  snapshot are absent; the original system/shared-cache framework path is used.
- SimpleBCM 1.2.0 and SimpleHDA 1.0.1 actually loaded. AMFIPass no longer loaded;
  native IOSkywalkFamily/IO80211Family are active.
- Bound an HTTPS request to the Wi-Fi interface and received HTTP 200.
  Enumerated built-in input/output, active Bluetooth and connected input device.
- Speaker playback, brightness control and waking from sleep are covered
  by the clean-system platform checks. This is basic functional acceptance, not every
  duration/device/Continuity combination.
- Preserved the custom battery a51m7, Dell activity-gate a51m1, Radeon a51m2,
  backlight 1.2.7, AppleALC and NaviAudioFixup bytes while updating official
  components. Native attached supply rating is 480 W for the tested pair;
  prior validated per-input reports agree at 240 W each. These are rated
  capacities, not measured wall power or a claim of two independent iStat rows.
- A 60-frame hardware-only H.264 encode at 1280x720 passed during the component
  update phase. It is not a long video/fence/VRAM-leak test of every later boot.

## Firmware requirements

AppleXcpmCfgLock=false requires CFG Lock to be disabled in firmware. Set the
quirk to true if firmware remains locked or its state is unknown. The quirk
is a compatibility patch; it does not change the firmware setting.

## Public packaging checks

Release checks cover identity fields, artifact checksums, dependency order and
OpenCore configuration validity. Privacy negative controls exercise rejection
of sensitive identifiers and capture containers.

The public EFI is derived from the deployed configuration with identity and
Bluetooth controller state removed and the diagnostic battery observer omitted.
The matching validator, privacy checks, manifest and dependency-order checks
must pass for the published commit. CI status must be read from its actual run;
local success must not be presented as a completed remote workflow.

Retained custom-source snapshots and binary hashes identify the publication.
No fresh whole-file reproducibility claim or full rebuild of every driver is
made. Backlight code-section comparisons and battery policy tests are documented
with their respective component maintenance history.

## Still open

- WindowServer software fence/synchronize timeouts recur. Migration success
  does not solve or attribute all desktop stalls.
- Display resolution may reset after sleep. Earlier captures already contain
  the same 1280x720 logical / 2560x1440 pixel 60 Hz mode; introduction by this
  upgrade is not established. No forced-resolution service was added.
- Permanent Universal Control/long-uptime brightness behavior, AirDrop, Handoff,
  Watch unlock, OTA, headphone/HDMI audio, card reader and all peripheral
  combinations require their own acceptance.
- SimpleBCM network traffic works and LoaderError is zero, but diagnostic
  command/notification error counters exist. Do not translate a successful
  connection into a claim of zero driver diagnostics. Upstream leaves the
  loader's StartedAwaitingHardware string after stack startup; that label
  alone is not proof that a currently working interface is absent.
- SIP/Authenticated Root were not tightened. NVMeFix causation is unproven;
  Thunderbolt reports are device-specific. See [TODO.md](../TODO.md).

No live EFI, BIOS, system cache, privacy identity or reboot state is changed by
publishing this release.
