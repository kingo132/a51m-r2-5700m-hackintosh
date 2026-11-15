#pragma once
#include <libkern/c++/OSSerialize.h>
#include <libkern/c++/OSUnserialize.h>

namespace NaviTelemetry {
constexpr unsigned MaxStatisticsBytes = 65536;
// IORegistryEntryCreateCFProperty serializes OSObjects before returning them.
// Kernel copyProperty does not: IOGPU installs an OSSerializer callback here.
// Return an owned dictionary without changing the original registry object.
inline OSDictionary *copyStatisticsDictionary(OSObject *property) {
    if (!property) return nullptr;
    if (auto dictionary = OSDynamicCast(OSDictionary, property)) {
        dictionary->retain(); return dictionary;
    }
    auto buffer = OSSerialize::withCapacity(4096);
    if (!buffer) return nullptr;
    OSDictionary *result = nullptr;
    if (property->serialize(buffer)) {
        auto length = buffer->getLength();
        auto text = buffer->text();
        if (text && length && length <= MaxStatisticsBytes && text[length-1] == '\0') {
            auto object = OSUnserializeXML(text, length, nullptr);
            result = OSDynamicCast(OSDictionary, object);
            if (object && !result) object->release();
        }
    }
    buffer->release();
    return result;
}
}
