# Release verification — 2026.11.15-oclp-free

## Reference machine: performed

- Confirmed running from the retained matching original Apple 25G241 snapshot.
  The additional on-disk AppleHDA and IO80211 framework files from the patched
  snapshot are absent; the original system/shared-cache framework path is used.
- SimpleBCM 1.2.0 and SimpleHDA 1.0.1 actually loaded. AMFIPass no longer loaded;
  native IOSkywalkFamily/IO80211Family are active.
- Bound an HTTPS request to the Wi-Fi interface and received HTTP 200.
  Enumerated built-in input/output, active Bluetooth and connected input device.
- Owner confirmed speaker playback, brightness control and waking from sleep
  after this clean-system boot. This is basic functional acceptance, not every
  duration/device/Continuity combination.
- Preserved the custom battery a51m7, Dell activity-gate a51m1, Radeon a51m2,
  backlight 1.2.7, AppleALC and NaviAudioFixup bytes while updating official
  components. Native attached supply rating is 480 W for the tested pair;
  prior validated per-input reports agree at 240 W each. These are rated
  capacities, not measured wall power or a claim of two independent iStat rows.
- A 60-frame hardware-only H.264 encode at 1280x720 passed during the component
  update phase. It is not a long video/fence/VRAM-leak test of every later boot.
- Promoted the accepted OCLP-free OC.test into OC and verified all bytes, with
  LauncherPath adjusted for the canonical directory. Removed the redundant test
  copy only after verified local backup. Removed OCLP-Mod app/helper/services.

## Deployed but not yet boot-accepted

- LucyRTL8125Ethernet 1.2.4 (Info.plist 1.2.400).
- AppleXcpmCfgLock=false, based on the owner's confirmation that the existing
  firmware setup script had already run. No independent all-core MSR read was
  performed. The temporary read-only check entry was removed at the owner's
  request. This does not prove the lock setting on any other machine.

## Public packaging checks

Local publication checks passed: 440 tracked files passed the release/privacy
checker with the private local denylist, all eight privacy negative-control
tests passed, and OpenCore 1.0.8 ocvalidate accepted the public config. Every
non-config EFI artifact was compared against the live reference bytes.

The public EFI is derived from the deployed configuration with identity and
Bluetooth controller state removed and the diagnostic battery observer omitted.
The matching validator, privacy checks, manifest and dependency-order checks
must pass for the published commit. CI status must be read from its actual run;
local success must not be presented as a completed remote workflow.

Retained custom-source snapshots and binary hashes identify the publication.
No fresh whole-file reproducibility claim or full rebuild of every driver is
made. Earlier backlight text/cstring comparison and battery policy tests belong
to the earlier recorded maintenance work, not newly invented test runs here.

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
