# Maintenance roadmap

The current release provides OCLP-free Wi-Fi and audio integration. The following
items track remaining engineering work; they are not installation prerequisites.

| Area | Objective |
| --- | --- |
| Display synchronization | Attribute intermittent WindowServer fence/synchronization delays and correct the responsible lifecycle path. |
| Display mode persistence | Preserve the selected mode through sleep, display reconfiguration and reconnects. |
| Brightness lifecycle | Preserve the native brightness target through display-object replacement and extended sleep/wake cycles. |
| Universal Control | Improve reconnect reliability and authenticated peer selection across network changes. |
| Wired Continuity | Evaluate authenticated Ethernet-first routing with native wireless fallback. |
| AirPlay routing | Select a reachable endpoint without requiring VPN shutdown. |
| Battery metadata | Extend firmware-backed reporting where supported; keep unavailable measurements distinct from synthesized values. |
| Adapter reporting | Expand plug/unplug and lifecycle coverage for per-input ratings and consumer UI behavior. |
| Radeon completion | Distinguish hardware completion, interrupt delivery and software-fence propagation during reproducible delays. |
| Peripheral coverage | Extend compatibility coverage for docking, Thunderbolt devices, HDMI/headphone audio and card readers. |

Changes should be tied to reproducible behavior and preserve native system
semantics. Prefer source-level fixes and supported configuration over polling
watchdogs, forced display resets or fabricated telemetry. Publish anonymized
technical evidence; keep machine identity and raw captures private.
