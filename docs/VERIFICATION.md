# Release validation

## Platform scope

Intel Alienware Area-51m R2, RX 5700M, macOS Tahoe 26.7.1 (25G241).
The OCLP-free integration uses the original Apple system snapshot, native
IOSkywalkFamily/IO80211Family, SimpleBCM 1.2.0 and SimpleHDA 1.0.1.

## Functional coverage

- System startup on the original Apple system volume without AMFIPass.
- Wi-Fi network traffic through the wireless interface.
- Internal audio-device enumeration and speaker playback.
- Internal brightness control and basic sleep/wake.
- Bluetooth controller and connected input-device operation.
- Custom battery, adapter-rating and sensor integration.

Hardware video encoding was exercised with a hardware-only H.264 workload.
This coverage does not establish every peripheral combination, long-uptime
behavior or performance characteristic.

## Package integrity

- OpenCore 1.0.8 ocvalidate accepts the release configuration.
- Release checks validate driver order, required paths, version metadata,
  checksum consistency and absence of obsolete root-patch injection.
- Privacy checks reject populated PlatformInfo identities and private capture
  containers. Eight negative-control tests exercise identity and encoding checks.
- [GitHub Actions](https://github.com/kingo132/a51m-r2-5700m-hackintosh/actions)
  runs release and privacy checks for published commits.
- [release-manifest.json](../release-manifest.json) identifies the distributed
  EFI artifacts and source snapshots. Complete binary reproducibility across
  different toolchains is not implied.

## Configuration requirements

`AppleXcpmCfgLock=false` requires CFG Lock to be disabled in firmware. Use
`true` when firmware is locked or its state is unknown. The software quirk
is a compatibility patch and does not change the firmware setting.

Keep the machine-specific AppleALC and sensor plugins when updating official
packages. The current profile retains its SIP and SecureBootModel policies.

## Known limitations

- Intermittent WindowServer synchronization/fence delays and display-mode
  persistence after sleep remain unresolved.
- Basic sleep/wake coverage does not establish indefinite wake-brightness,
  Universal Control reconnection or all long-uptime scenarios.
- Continuity features, OTA compatibility and peripheral behavior depend on
  the complete hardware, account and operating-system configuration.
- SimpleBCM command/notification counters are diagnostic indicators, not
  packet-loss measurements. Its loader status string alone does not describe
  the current interface's operational state.
- Battery firmware ratings and compatibility metadata are not calibrated
  electrical measurements; see [battery reporting](BATTERY_FIELDS.md).
