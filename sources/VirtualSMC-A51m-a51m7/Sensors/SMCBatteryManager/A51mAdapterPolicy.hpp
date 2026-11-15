// Firmware rating policy, shared with hardware-free tests. Not a wattmeter.
#ifndef A51M_ADAPTER_POLICY_HPP
#define A51M_ADAPTER_POLICY_HPP
#include "A51mDellTelemetry.hpp"
namespace A51mAdapter {
constexpr uint64_t MaxAgeNs = 120000000000ULL;
inline uint32_t designWatts(const A51mDell::Telemetry &raw, uint64_t now, bool connected) {
    // Windows IAdaptor::GetDesignPower uses selector 3 for the attached
    // system's available rated power. Selector 6 supplies AC/PSID flags;
    // its static AX value is NOT the attached pair's total (330 vs 480 W).
    if (!connected || raw.schema != A51mDell::Schema ||
        raw.status != A51mDell::Status::Active ||
        (raw.adapterValid & ((1U << 3) | (1U << 6))) != ((1U << 3) | (1U << 6)) ||
        (raw.adapterBx[6] & 3) != 3 || !raw.adapterSampledNs ||
        now < raw.adapterSampledNs || now - raw.adapterSampledNs > MaxAgeNs)
        return 0;
    auto watts = raw.adapterAx[3];
    return watts && watts <= 3000 ? watts : 0;
}
// The hook is only reached on the native gated SMC-completion path.
inline bool isAdapterUpdate(uint32_t command) {
    return command == 0xd00 || command == 0x1300;
}
// Exact tested Intel AppleSmartBatteryManager image, not a platform model ID.
inline bool knownImage(const uint8_t *p, size_t size) {
    static const uint8_t uuid[] = {0x9d,0x50,0x23,0x81,0xbc,0x1e,0x30,0x66,
                                  0x95,0xe3,0xca,0xab,0x88,0xaf,0x87,0x3e};
    if (!p || size < 32 || A51mDell::get32(p) != 0xfeedfacf ||
        A51mDell::get32(p + 4) != 0x01000007) return false;
    auto count = A51mDell::get32(p + 16), bytes = A51mDell::get32(p + 20);
    if (bytes > size - 32 || count > bytes / 8) return false;
    size_t at = 32, end = 32 + bytes; bool found = false;
    for (uint32_t i = 0; i < count; ++i) {
        if (end - at < 8) return false;
        auto cmd = A51mDell::get32(p + at), length = A51mDell::get32(p + at + 4);
        if (length < 8 || length > end - at) return false;
        if (cmd == 0x1b) {
            if (found || length != 24) return false;
            for (size_t j = 0; j < sizeof(uuid); ++j)
                if (p[at + 8 + j] != uuid[j]) return false;
            found = true;
        }
        at += length;
    }
    return found && at == end;
}
}
#endif
