# Battery field accuracy

## Current packaged build: a51m7

The packaged reference driver has advanced beyond the earlier a51m1 audit
below. Its fresh Dell adapter bridge reports a firmware-rated total of
480 W for the tested pair, with validated 240 W + 240 W port ratings. Those
are attached supply **ratings**, not measured instantaneous consumption. The
reference system export agrees with the total; separate port diagnostics do
not imply that iStat exposes two independent rows.

The old synthetic per-cell voltages are not current measurements and must
not be presented as such. Unsupported fields remain unavailable; their exact
consumer UI needs separate acceptance. A cycle count is now reported, but no
independent lifetime-count calibration is claimed. The current release keeps
this distinction rather than filling missing fields with plausible numbers.

## Read-only checkpoint recorded on 2026-11-15

The deployed a51m7 driver now reports 21 cycles, real cached temperature,
480 W total adapter rating and two validated 240 W input ratings. Current
registry values are about 12.33 V and 0 mA on AC with charging paused; the
pack reports 5,861 mAh remaining, 7,077 mAh full-charge and 7,895 mAh design.
The two synthetic adapter/cell SMC metadata fields are omitted. These changes
supersede the old 60 W / 16 V / zero-cycle observations below. They do not
make rated watts measured consumption or establish complete battery health.
See [current acceptance evidence and limits](UI_MON_ACCEPTANCE_20261115.md).

## Historical a51m1 audit — observations below are not current values

The following historical audit checked then-current AppleSmartBattery values and the then-deployed
[A51m VirtualSMC source](https://github.com/kingo132/VirtualSMC/tree/05fe28585a568d61246d6b43a1d982d1ef9c6120)
on 2026-11-15. The battery time-policy repair does **not** make every exported
metadata field a hardware measurement. iStat Menus displays several values
supplied by the compatibility driver.

| Displayed field | Historical observation | Meaning and confidence |
| --- | --- | --- |
| Adapter power | 60 W | Placeholder. `KeyImplementations.cpp`, `ACID::readAccess`, supplies a fixed dummy adapter descriptor including byte `0x3c`. This is not measured input power or verified adapter rating. |
| Battery power | 0 W | Consistent with reported battery current zero while on AC with charging paused by the configured thresholds. This is battery flow, not total computer power. |
| Battery amperage | 0 A | Matches both current system current fields and the earlier ACPI observer state/rate 0/0. |
| Battery voltage | About 12.3 V | Matches the current pack report around 12347 mV. The driver exports presentVoltage; this is pack voltage, not a cell voltage. No external meter calibration is claimed. |
| Cycles | 0 | Not established as a real lifetime count. The extended ACPI path exports the supplied `_BIX` cycle field; the legacy `_BIF` fallback estimates cycles from capacity loss. A real firmware/independent-OS comparison is still needed. |
| Condition | Normal | Limited to the system/driver's available status checks. It is not an independent physical-health test; manufacturer failure/operation status replies are currently synthesized as zero. |
| Design capacity | 7895 mAh | Matches the current normalized firmware/driver design-capacity field. Independent calibration is still pending. |
| Current capacity in the health section | 7077 mAh | Matches current **full-charge capacity**, not remaining charge. Remaining charge in this capture is about 5915 mAh, or 84%. Full/design capacity is about 89.6%; that ratio alone is not a complete health diagnosis. |
| Cell 1 voltage | 16 V | Placeholder, not a measurement. `SMCSMBusController.cpp` returns `defaultBatteryCellVoltage` for every cell-voltage command, and `SMCBatteryManager.cpp` exports the same constant through the SMC cell key. The SDK defines it as 16000 mV. Do not replace it with pack voltage or a guessed equal-per-cell split. |

Additional unsupported defaults exist: battery temperature starts at 2931
deci-kelvin (about 20 C), requested charging voltage at 8000 mV, and design
cycle count at 1000. They require actual supplement support to become meaningful;
they are not evidence of a defective charger, a real 8 V charging command or a
measured temperature. Current supplement configuration is zero.

Next repair is to identify the supported firmware/EC data sources and the
correct consumer behavior for unavailable information. Validate per-command
unknown/unsupported handling before changing the virtual SMBus contract. Do
not patch the monitor app, hardcode an adapter wattage, invent cell readings
or alter charging behavior to make labels look plausible.

Charging starts below 50% and stops at 80% on the owner's current BIOS policy.
AC attached/not charging around 84% therefore does not indicate a defect.
The manually initiated shutdown is not a battery failure report.
