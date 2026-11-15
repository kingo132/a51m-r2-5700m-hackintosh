// Numeric-only observation of the ACPI package already read by the driver.
#ifndef A51M_BATTERY_STATIC_INFO_HPP
#define A51M_BATTERY_STATIC_INFO_HPP
#include <stdint.h>
namespace A51mBattery {
struct StaticInfo {
    uint32_t method {0}; // 0: not captured; 1: _BIF; 2: _BIX.
    uint32_t packageCount {0};
    // _BIX has 16 numeric fields before its identifying strings; _BIF has 9.
    // Missing/non-numeric elements are 0xffffffff. No identifying strings.
    uint32_t values[16] {};
};
static_assert(sizeof(StaticInfo) == 72, "Static information schema changed");
}
#endif
