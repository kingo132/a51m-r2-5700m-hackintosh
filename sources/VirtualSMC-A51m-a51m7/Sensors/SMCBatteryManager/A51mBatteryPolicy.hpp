// Optional A51m telemetry policy. No hardware access or current modification.
#ifndef A51M_BATTERY_POLICY_HPP
#define A51M_BATTERY_POLICY_HPP
#include <stdint.h>

namespace A51mBattery {
static constexpr uint32_t Unknown = 0xffffffffU;
static constexpr uint32_t UnknownTime = 0xffffU;

inline uint32_t minutes(uint32_t capacity, uint32_t rate) {
	if (capacity == Unknown || rate == 0 || rate == Unknown)
		return UnknownTime;
	const uint64_t value = uint64_t(capacity) * 60 / rate;
	return value < UnknownTime ? uint32_t(value) : UnknownTime;
}

inline uint32_t hardwareMinutes(uint32_t value) {
	return value < UnknownTime ? value : UnknownTime;
}

// Called after upstream status/critical calculations. Preserve all non-time fields.
template <typename State>
inline void applyTimePolicy(State &st, bool validCapacity, bool validPresentRate,
		bool validAverageRate, bool useHardwareEmpty, bool useHardwareFull) {
	st.runTimeToEmpty = st.averageTimeToEmpty = st.timeToFull = UnknownTime;
	if (!validCapacity)
		return;
	const uint32_t mode = st.state & 3U;
	if (mode == 1U) {
		if (validPresentRate)
			st.runTimeToEmpty = minutes(st.remainingCapacity, st.presentRate);
		if (validAverageRate)
			st.averageTimeToEmpty = useHardwareEmpty ? hardwareMinutes(st.averageTimeToEmptyHW) :
				minutes(st.remainingCapacity, st.averageRate);
	} else if (mode == 2U && validAverageRate && st.lastFullChargeCapacity != Unknown &&
			st.lastFullChargeCapacity >= st.remainingCapacity) {
		st.timeToFull = useHardwareFull ? hardwareMinutes(st.timeToFullHW) :
			minutes(st.lastFullChargeCapacity - st.remainingCapacity, st.averageRate);
	}
}
}
#endif
