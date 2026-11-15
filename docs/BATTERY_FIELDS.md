# Battery and adapter reporting

The A51m battery extension distinguishes firmware reports, compatibility fields
and unavailable measurements. Monitoring applications display driver-supplied
values; those values are not automatically calibrated electrical measurements.

## Adapter ratings

SMCBatteryManager a51m7 obtains the attached supply rating through the Dell
firmware interface and validates per-input reports before publication. A pair of
240 W supplies is represented as a 480 W total rating with two 240 W input
ratings. These are supply capacities, not instantaneous computer consumption.

The native adapter bridge publishes the total rating. Separate per-input
telemetry does not imply that every monitoring application provides separate
adapter rows. Ambiguous, stale or inconsistent reports must remain unavailable
rather than being replaced by a fixed wattage.

## Field interpretation

| Field | Meaning |
| --- | --- |
| Battery current and power | Battery charge/discharge flow; not total system input power. Zero current on AC can be normal when charging is paused. |
| Battery voltage | Pack-voltage report; not an individual cell measurement. |
| Full-charge capacity | Estimated capacity at full charge; distinct from remaining charge. |
| Design capacity | Firmware-reported nominal capacity; not an independent health measurement. |
| Cycle count | Firmware/compatibility report; interpret according to the available ACPI data source. |
| Condition | Available status checks; not a substitute for physical battery diagnostics. |
| Cell voltage and other unsupported metadata | Unavailable unless a suitable firmware source exists. Do not substitute pack voltage, guessed cell splits or plausible constants. |

Earlier a51m1 builds used compatibility placeholders including a fixed 60 W
adapter descriptor and 16 V cell values. Those historical values must not be
interpreted as measurements or applied to the current adapter-rating bridge.

Firmware charge thresholds can leave a connected battery idle above the start
threshold or after reaching the stop threshold. This behavior alone is not a
charging-driver failure.

The source overlay and artifact checksums are included in the release manifest.
Further work focuses on supported metadata sources, consumer handling of
unavailable values and adapter lifecycle behavior; see [the roadmap](../TODO.md).
