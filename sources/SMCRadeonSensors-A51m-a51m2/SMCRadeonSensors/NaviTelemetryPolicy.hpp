// A51m extension: cached Apple-driver reports, never GPU control or guessed data.
#pragma once
#include <stdint.h>
#include <stddef.h>
namespace NaviTelemetry {
constexpr const char *Revision = "2.4.0-a51m2-candidate";
enum class Metric : uint8_t { Temperature, Power, CoreClock, MemoryClock, Activity, VramUsed, VramFree, DeviceUtilization, Count };
constexpr size_t Count = size_t(Metric::Count);
constexpr const char *Names[Count] = {
    "Temperature(C)", "Total Power(W)", "Core Clock(MHz)", "Memory Clock(MHz)",
    "GPU Activity(%)", "inUseVidMemoryBytes", "vramFreeBytes", "Device Utilization %"
};
// sp78 has a signed integer byte; 128 C would wrap negative and is rejected.
constexpr uint64_t Limits[Count] = {127, 511, 4000, 8000, 100, 64ULL << 30, 64ULL << 30, 100};
struct Snapshot {
    uint64_t observedNs {0}, values[Count] {};
    uint32_t valid {0};
    bool has(Metric metric) const { return size_t(metric) < Count && (valid & (1U << uint8_t(metric))) != 0; }
};
inline bool eligible(bool optIn, uint32_t vendor, uint32_t device, uint32_t subsystemVendor, uint32_t subsystem) {
    return optIn && vendor == 0x1002 && device == 0x731f && subsystemVendor == 0x1028 && subsystem == 0x099d;
}
// Reader returns only numeric fields. Unknown values stay absent, not zero.
template <class Reader> Snapshot decode(Reader &reader, uint64_t observedNs) {
    Snapshot result {}; result.observedNs = observedNs;
    for (size_t i = 0; i < Count; ++i) {
        uint64_t value = 0;
        if (reader.number(Names[i], value) && value <= Limits[i]) {
            result.values[i] = value; result.valid |= 1U << i;
        }
    }
    return result;
}
// Explicit custom memory keys use ui64 bytes, clocks ui32 MHz, load ui8 %.
// The two fixed-point keys follow upstream's temperature/power encodings.
inline size_t encodedSize(Metric metric) {
    switch (metric) {
        case Metric::Temperature: case Metric::Power: return 2;
        case Metric::CoreClock: case Metric::MemoryClock: return 4;
        case Metric::Activity: case Metric::DeviceUtilization: return 1;
        case Metric::VramUsed: case Metric::VramFree: return 8;
        default: return 0;
    }
}
inline bool encode(const Snapshot &raw, Metric metric, uint8_t *output, size_t size) {
    auto index = size_t(metric);
    if (index >= Count || !output || !raw.has(metric) || size != encodedSize(metric)) return false;
    uint64_t value = raw.values[index];
    // Validate again at the consumer boundary, including hand-built snapshots.
    if (value > Limits[index]) return false;
    if (metric == Metric::Temperature) value <<= 8;  // sp78, non-negative C
    if (metric == Metric::Power) value <<= 6;        // sp96, whole W report
    for (size_t i = 0; i < size; ++i) output[size - 1 - i] = uint8_t(value >> (8 * i));
    return true;
}
}
