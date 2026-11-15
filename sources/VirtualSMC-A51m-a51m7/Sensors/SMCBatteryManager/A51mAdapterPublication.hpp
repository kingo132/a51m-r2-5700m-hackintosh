// Native power-source enrichment, separated from routing for owned lifecycle tests.
#pragma once
#include "A51mAdapterPolicy.hpp"
#include <Headers/kern_time.hpp>
#include <IOKit/pwr_mgt/IOPMPowerSource.h>
namespace A51mAdapter {
// Form an inherited base member pointer in a legal protected-access context.
// Invoke it on the real IOPMPowerSource, without an invalid derived downcast.
class PropertyAccess : public IOPMPowerSource {
public:
    using Setter = void (IOPMPowerSource::*)(const OSSymbol *, OSObject *);
    static Setter setter() { return &PropertyAccess::setPSProperty; }
};
inline void publish(IOService *service, const OSSymbol *detailsKey) {
    if (!service || !detailsKey ||
        strcmp(service->getMetaClass()->getClassName(), "AppleSmartBattery")) return;
    auto source = OSDynamicCast(IOPMPowerSource, service);
    auto manager = service->getProvider();
    if (!source || !manager || strcmp(manager->getMetaClass()->getClassName(), "AppleSmartBatteryManager")) return;
    auto controller = manager->getProvider();
    if (!controller || strcmp(controller->getMetaClass()->getClassName(), "SMCSMBusController")) return;
    auto current = OSDynamicCast(OSDictionary, source->getPSProperty(detailsKey));
    if (!current) return;
    const bool ours = current->getObject("A51mFirmwareDesignRating") == kOSBooleanTrue;
    // A valid original Apple provider always takes precedence.
    if (!ours && current->getObject("Watts")) return;
    uint32_t watts = 0;
    auto property = controller->copyProperty("A51mDellTelemetry");
    auto data = OSDynamicCast(OSData, property);
    if (data && data->getLength() == sizeof(A51mDell::Telemetry)) {
        A51mDell::Telemetry raw {};
        memcpy(&raw, data->getBytesNoCopy(), sizeof(raw));
        watts = designWatts(raw, getCurrentTimeNs(), source->externalConnected());
    }
    if (property) property->release();
    auto oldWatts = OSDynamicCast(OSNumber, current->getObject("Watts"));
    if ((!watts && !ours) || (ours && oldWatts && oldWatts->unsigned32BitValue() == watts)) return;
    auto copy = OSDictionary::withDictionary(current);
    if (!copy) return;
    if (watts) {
        auto number = OSNumber::withNumber(uint64_t(watts), 32);
        if (!number) { copy->release(); return; }
        bool ok = copy->setObject("Watts", number) &&
                  copy->setObject("A51mFirmwareDesignRating", kOSBooleanTrue);
        number->release();
        if (!ok) { copy->release(); return; }
    } else {
        // Invalidate only the field owned by this bridge, never native data.
        copy->removeObject("Watts");
        copy->removeObject("A51mFirmwareDesignRating");
    }
    (source->*PropertyAccess::setter())(detailsKey, copy);
    copy->release();
    // Preserve Apple's transaction boundary: its native helper also uses
    // setPSProperty here. The enclosing poll's normal updateStatus publishes
    // the whole battery state; never flush a partially completed poll here.
    service->setProperty("A51mAdapterDesignRatingWatts", uint64_t(watts), 32);
}

}
