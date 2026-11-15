// Fixed-size, pointer-free trace format. Observes existing reads only.
#ifndef A51M_BATTERY_TELEMETRY_HPP
#define A51M_BATTERY_TELEMETRY_HPP
#include <stdint.h>

namespace A51mBattery {
struct Snapshot {
	uint64_t sequence {0}, sampleNs {0};
	uint64_t rawState {0}, rawRate {0}, rawCapacity {0}, rawVoltage {0};
	uint64_t powerUnitIsWatt {0}, designVoltage {0}, state {0};
	uint64_t presentRate {0}, averageRate {0};
	int64_t signedPresentRate {0}, signedAverageRate {0};
	uint64_t remainingCapacity {0}, lastFullChargeCapacity {0};
	uint64_t upstreamRuntime {0}, upstreamAverageTime {0}, upstreamFullTime {0};
	uint64_t runtime {0}, averageTime {0}, fullTime {0}, policyEnabled {0};
	uint64_t supplementConfig {0}, previousCapacity {0}, quickPoll {0};
	int64_t hardwareAverageRate {0};
};
static_assert(sizeof(Snapshot) == 26 * sizeof(uint64_t), "Snapshot must have no padding");

struct Record {
	uint64_t eventSequence {0}, eventNs {0}, phase {0};
	uint64_t command {0}, value {0}, receiveCount {0};
	uint64_t expectedCommand {0}, expectedValue {0};
	uint64_t requestSequence {0};
	Snapshot source {};
};
static_assert(sizeof(Record) == 35 * sizeof(uint64_t), "Record must have no padding");

struct Trace {
	static constexpr uint64_t Capacity = 64;
	uint64_t magic {0x315441424d313541ULL}, schema {1}, recordWords {35}, capacity {Capacity};
	uint64_t used {0}, nextIndex {0}, total {0}, overwritten {0};
	uint64_t dropped {0}, reserved {0};
	Record records[Capacity] {};

	void append(Record record) {
		record.eventSequence = ++total;
		records[nextIndex] = record;
		nextIndex = (nextIndex + 1) % Capacity;
		if (used < Capacity)
			++used;
		else
			++overwritten;
	}
};
static_assert(sizeof(Trace) == (10 + 64 * 35) * sizeof(uint64_t), "Trace must have no padding");
}
#endif
