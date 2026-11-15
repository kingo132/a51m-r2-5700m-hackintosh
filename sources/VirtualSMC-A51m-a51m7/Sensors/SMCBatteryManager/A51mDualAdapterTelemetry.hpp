// Rated supply metadata, never measured input power or a power-limit control.
#pragma once
#include <stdint.h>
namespace A51mDualAdapter {
enum class Status : uint32_t {
    Disabled, NoEndpoint, InvalidDescriptor, TransportError, SlowTransport,
    Inconsistent, Active
};
struct Telemetry {
    uint32_t schema {1};
    Status status {Status::Disabled};
    uint64_t sequence {0}, sampledNs {0};
    uint32_t countBefore {0}, countAfter {0}, ratedWatts[2] {};
    uint32_t firmwareStatus {0}, validMask {0};
    uint32_t requests {0}, failures {0}, maxDurationUs {0}, reserved {0};
    uint64_t sourceSampledNs {0}; // Exact LegacyDiags total used for this pair.
};
static_assert(sizeof(Telemetry)==72,"Dual adapter telemetry layout changed");
inline bool validPair(const Telemetry &d, uint64_t now, uint32_t total, uint64_t sourceNs) {
    return d.schema==1 && d.status==Status::Active && d.validMask==3 &&
        d.sampledNs && now>=d.sampledNs && now-d.sampledNs<=120000000000ULL &&
        sourceNs && d.sourceSampledNs==sourceNs && sourceNs<=d.sampledNs &&
        now-sourceNs<=120000000000ULL && d.countBefore==2 && d.countAfter==2 &&
        (d.firmwareStatus==1 || d.firmwareStatus==2) &&
        d.ratedWatts[0]>0 && d.ratedWatts[0]<=3000 &&
        d.ratedWatts[1]>0 && d.ratedWatts[1]<=3000 &&
        total>0 && total<=3000 && d.ratedWatts[0]+d.ratedWatts[1]==total;
}
}
