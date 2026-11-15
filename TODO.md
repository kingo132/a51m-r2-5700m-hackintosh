# Current migration checkpoint

- OCLP-free reference boot, Wi-Fi network access, speakers, brightness and
  basic sleep/wake passed; OCLP-Mod is removed and the matching original Apple
  system snapshot is active. This does not close the broader lifecycle tasks.
- The current reference battery build is a51m7: its native 480 W attached
  supply rating agrees with validated 240 + 240 W reports. Earlier BAT-00
  placeholder descriptions below are historical and need remaining consumer,
  plug/unplug and lifecycle acceptance rather than another fixed-value patch.
- Ethernet 1.2.4 and AppleXcpmCfgLock=false are deployed but pending a new
  boot. CFG status is based on owner-confirmed prior firmware setup, not an
  independent MSR check.
- Display resolution persistence remains open. Earlier captures show the
  same 1280x720 logical / 2560x1440 pixel, 60 Hz mode, so introduction by this
  update is unproven. Do not add a periodic forced-resolution service.
- Validate AirDrop, Handoff, Watch unlock, HDMI/headphone audio, SD card and
  OTA behavior separately before expanding the compatibility claims.

# Repair backlog

Updated: 2026-11-15. Work from lower to higher estimated repair difficulty.
Order is a work queue, not a claim that a low-impact task matters more.
Difficulty is provisional and may change when new evidence becomes available.
High-impact items can be advanced explicitly. Completed fixes are in
[CHANGELOG.md](CHANGELOG.md).

| Order | ID | Difficulty | User impact | Open item and acceptance target |
| --- | --- | --- | --- | --- |
| 1 | NET-01 | Low–medium | High | Make AirPlay discovery avoid an unreachable VPN endpoint without disabling the VPN. Repeated fresh sessions must use a reachable local endpoint and disconnect cleanly with the VPN running. |
| 2 | UI-01 | Low–medium | Medium | Validate the notification-center/world-clock mitigation over extended uptime. Confirm callback counts and CPU/memory stay bounded; distinguish widget removal from an upstream drawing-lifetime fix. |
| 2a | MON-01 | Low–medium | Medium | Validate the purchased iStat Menus 7 upgrade with the restored layout and Stats stopped. Check real sensor/menu behavior and bounded CPU/window callbacks over extended uptime; do not attribute version 6 findings to version 7 without new evidence. Keep license and settings backups private. |
| 2b | BAT-00 | Low–medium, provisional | Medium | Correct unsupported battery metadata reporting: fixed 60 W adapter descriptor, fixed 16 V cell value and other fallback fields. Verify actual firmware data availability and per-command unknown/unsupported consumer behavior before changing the ABI. Never substitute guessed watts or cell voltages. See [field audit](docs/BATTERY_FIELDS.md). |
| 3 | DSP-01 | Medium | High | Finish displaypolicyd/Built-In-map lifecycle acceptance: repeated boots, mode changes, external-display changes and sleep/wake, without identity-transition aborts or TG regressions. |
| 4 | ACC-01 | Medium | Low | Identify which account-validation requests trigger Contacts retries. Determine the caller and supported correction; do not delete system accounts or databases without review. |
| 5 | BAT-01 | Medium | Medium | Validate cycle-count and other suspect battery fields against the current ACPI source and an independent OS. Change an SSDT only if a concrete firmware-interface defect is demonstrated; never invent missing sensor data. |
| 6 | APP-01 | Medium–high | High | Capture actual typing/scrolling/clicking stalls in a long conversation. Correlate input events, layout work, compositor waits and server dispatch; normal-period forced-layout samples alone are insufficient. |
| 7 | BAT-02 | High | Medium | Explain the historical 31 A battery-current excursion. Match the same raw source sequence and virtual-SMBus request at preparation/completion with the system value. Do not infer a current fix from the corrected time overflow or clamp current. |
| 8 | UC-01 | High | Critical | Permanently repair peer-Mac Universal Control reconnect failure. An authenticated inbound connection can become Ready while another discovery request times out after 15 seconds and cancels it. Verify destination-metadata handoff, same-device matching, pending-request attachment and timer cancellation. Repeated sleep/wake reconnects must work without restarting ensemble or adding a watchdog. |
| 9 | BKL-01 | High | High | Preserve the user's actual internal brightness across display rebind/wake. Observe replacement AppleBacklightDisplay objects and later EDR writes; fix the responsible target/state handoff, not a periodic brightness reset. Test both logical target and panel parameters and restore the original setting after each test. |
| 10 | WS-01 | High | High | Resolve the remaining WindowServer software-fence timeouts. Correlate each fence with live client handles and display-reconfiguration/server-lock timing. Earlier ControlCenter attribution applies only to its captured events; later untraced events must be attributed separately. |
| 11 | GPU-01 | Very high | High | Explain old AMD completion delays/Metal failures. Obtain or otherwise discriminate the final hardware fence and raw interrupt-ring stage during a real failure. Do not label software stamps, ordinary resource-residency delays or polling workarounds as proof of missing hardware interrupts. Include long-uptime VRAM growth/release measurements before claiming a leak. |
| 12 | UC-02 | Very high | High | Implement real Ethernet-first Universal Control with authenticated same-peer selection and native AWDL fallback. Component-level wired tests passed, but the system policy is not deployed. Validate cross-Mac authentication, interface/address changes, loss/recovery of Ethernet and sleep/wake without reducing system protection. |
| Deferred | BKL-02 | Medium, provisional | Cosmetic | Synchronize the existing brightness HUD with actual maximum/step values. Keep deferred by user choice. Backend full-scale success is not on-screen acceptance; require synchronized screen/value capture. |
| Monitor | CHR-01 | Undetermined | Unproven | Chrome host_statistics warnings: no demonstrated buffer-size defect or causal link to stutter. Escalate only with correlated failure evidence; no speculative EFI/browser patch. |

- [ ] NET-01: permanent reachable AirPlay endpoint selection.
- [ ] UI-01: extended-uptime widget mitigation acceptance.
- [ ] MON-01: iStat Menus 7 layout and uptime acceptance.
- [ ] BAT-00: accurate handling of unavailable adapter/cell metadata.
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
- [ ] BKL-02: deferred HUD synchronization.
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
