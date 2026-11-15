//
//  kern_diagnostics.hpp
//  A51mR2Backlight
//
//  Small helper for publishing runtime state on the plugin IOService.
//  This keeps bring-up diagnostics out of the patching logic and makes
//  post-boot validation possible without relying on early kernel logs.
//

#ifndef kern_diagnostics_hpp
#define kern_diagnostics_hpp

#include <Headers/plugin_start.hpp>
#include <libkern/c++/OSBoolean.h>

namespace A51Diagnostics {

inline IOService *service() {
    return ADDPR(selfInstance);
}

inline void setBool(const char *key, bool value) {
    auto target = service();
    if (target != nullptr)
        target->setProperty(key, value ? kOSBooleanTrue : kOSBooleanFalse);
}

inline void setUInt32(const char *key, uint32_t value) {
    auto target = service();
    if (target != nullptr)
        target->setProperty(key, value, 32);
}

inline void setString(const char *key, const char *value) {
    auto target = service();
    if (target != nullptr && value != nullptr)
        target->setProperty(key, const_cast<char *>(value),
                            static_cast<uint32_t>(strlen(value) + 1));
}

} // namespace A51Diagnostics

#endif /* kern_diagnostics_hpp */
