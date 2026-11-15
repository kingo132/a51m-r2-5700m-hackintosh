// Fixed-size, provenance-tagged cache; invalid fields never become measurements.
#ifndef A51M_DELL_TELEMETRY_HPP
#define A51M_DELL_TELEMETRY_HPP
#include "A51mDellProtocol.hpp"
namespace A51mDell {
enum class Status : uint32_t {
    Disabled, NotCaptured, NoEndpoint, InvalidDescriptor, BadSignature,
    TransportError, SlowTransport, Active
};
struct Telemetry {
    uint32_t schema {Schema};
    Status status {Status::Disabled};
    uint64_t sequence {0}, sampledNs {0}, staticSampledNs {0};
    uint64_t valid {0};
    uint32_t specVersion {0}, requests {0}, failures {0}, maxDurationUs {0};
    uint32_t adapterValid {0}, stringValid {0};
    uint16_t numeric[64] {};
    uint16_t adapterAx[7] {}, adapterBx[7] {};
    uint16_t stringLength[5] {};
    // Manufacturer, model, chemistry, vendor data, ePPID. Private at runtime.
    uint8_t strings[5][256] {};
    uint16_t reserved {0}; // Explicit tail bytes: never export uninitialized padding.
    uint64_t adapterSampledNs {0};
    bool has(Field f) const {return (valid & (uint64_t(1)<<uint8_t(f)))!=0;}
    void set(Field f,uint16_t v) {numeric[uint8_t(f)]=v;valid|=uint64_t(1)<<uint8_t(f);}
};
static_assert(sizeof(Telemetry)==1520,"Dell telemetry schema changed");
}
#endif
