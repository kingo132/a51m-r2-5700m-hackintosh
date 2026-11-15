// A51m R2 BIOS 1.37.0 WMAX PowerInformation read operations, called only
// from the existing opt-in battery poll. No EC writes, timers or SMI access.
#pragma once
#include "A51mDualAdapterTelemetry.hpp"
#include <IOKit/acpi/IOACPIPlatformDevice.h>
#include <Headers/kern_time.hpp>
namespace A51mDualAdapter {
class Reader {
    bool stopped {false};
    uint64_t lastAttemptNs {0};
    static bool descriptor(const uint8_t *p, size_t n) {
        static const uint8_t guid[]={0xce,0x91,0x05,0xa7,0x97,0xa9,0xda,0x11,
                                    0xb0,0x12,0xb6,0x22,0xa1,0xef,0x54,0x92};
        if(!p || !n || n>4096 || n%20) return false;
        for(size_t i=0;i<n;i+=20) {
            bool same=true;
            for(size_t j=0;j<16;++j) if(p[i+j]!=guid[j]) same=false;
            if(same && p[i+16]=='A' && p[i+17]=='X' && p[i+18]==1 &&
               p[i+19]==2) return true;
        }
        return false;
    }
    IOACPIPlatformDevice *endpoint() {
        auto it=IORegistryIterator::iterateOver(gIOACPIPlane,kIORegistryIterateRecursively);
        if(!it) return nullptr;
        IOACPIPlatformDevice *found=nullptr;
        while(auto entry=it->getNextObject()) {
            if(!entry->getName() || strcmp(entry->getName(),"AMW1")) continue;
            auto device=OSDynamicCast(IOACPIPlatformDevice,entry);
            if(device) {device->retain();found=device;break;}
        }
        it->release();return found;
    }
    bool query(IOACPIPlatformDevice *device,uint8_t op,uint8_t port,uint32_t &value) {
        // Deliberately no generic caller: only these inspected read branches.
        if(stopped || !((op==1 || op==4) ? port==0 : op==2 && port<2)) return false;
        uint8_t bytes[]={op,port,0,0};
        auto instance=OSNumber::withNumber(uint64_t(0),32);
        auto method=OSNumber::withNumber(uint64_t(0x1c),32);
        auto input=OSData::withBytes(bytes,sizeof(bytes));
        bool ok=false;
        if(instance && method && input) {
            OSObject *args[]={instance,method,input};OSObject *result=nullptr;
            auto before=getCurrentTimeNs();
            auto ret=device->evaluateObject("WMAX",&result,args,3);
            auto us=(getCurrentTimeNs()-before)/1000;
            ++data.requests;
            if(us>data.maxDurationUs) data.maxDurationUs=us>UINT32_MAX ? UINT32_MAX : uint32_t(us);
            auto number=OSDynamicCast(OSNumber,result);
            if(ret==kIOReturnSuccess && number && number->unsigned64BitValue()<=UINT32_MAX) {
                value=uint32_t(number->unsigned64BitValue());ok=value!=UINT32_MAX;
            }
            if(result) result->release();
            // This cannot interrupt firmware. Stop subsequent calls if one
            // returned slowly; never disable the independent battery reader.
            if(us>20000) {stopped=true;data.status=Status::SlowTransport;ok=false;}
        }
        if(instance) instance->release();
        if(method) method->release();
        if(input) input->release();
        if(!ok) ++data.failures;
        return ok;
    }
public:
    Telemetry data {};
    void invalidate() {
        if(!data.validMask && !data.sampledNs) return;
        data.validMask=0;data.sampledNs=0;data.sourceSampledNs=0;
        data.status=stopped ? Status::SlowTransport : Status::Disabled;
        ++data.sequence;
    }
    bool refresh(bool enabled, uint32_t total, uint64_t sourceNs) {
        if(!enabled || !total || total>3000 || !sourceNs) {invalidate();return false;}
        if(stopped) return false;
        auto now=getCurrentTimeNs();
        if(lastAttemptNs && now-lastAttemptNs<1000000000ULL) return false;
        lastAttemptNs=now;data.validMask=0;data.sampledNs=0;data.sourceSampledNs=sourceNs;
        data.countBefore=data.countAfter=data.ratedWatts[0]=data.ratedWatts[1]=data.firmwareStatus=0;
        ++data.sequence;
        auto device=endpoint();
        if(!device) {data.status=Status::NoEndpoint;return false;}
        OSObject *object=nullptr;bool eligible=false;
        if(device->evaluateObject("_WDG",&object)==kIOReturnSuccess) {
            auto buffer=OSDynamicCast(OSData,object);
            eligible=buffer && descriptor(static_cast<const uint8_t*>(buffer->getBytesNoCopy()),buffer->getLength());
        }
        if(object) object->release();
        if(!eligible || device->validateObject("WMAX")!=kIOReturnSuccess) {
            data.status=Status::InvalidDescriptor;device->release();return false;
        }
        data.status=Status::TransportError;
        bool ok=query(device,1,0,data.countBefore);
        if(ok && data.countBefore>0 && data.countBefore<=2) {
            ok=query(device,2,0,data.ratedWatts[0]) &&
               query(device,2,1,data.ratedWatts[1]) &&
               query(device,4,0,data.firmwareStatus) &&
               query(device,1,0,data.countAfter);
        } else if(ok) {
            data.countAfter=data.countBefore;
        }
        device->release();
        if(!ok) return false;
        data.status=Status::Active;data.sampledNs=getCurrentTimeNs();data.validMask=3;
        if(!validPair(data,data.sampledNs,total,sourceNs)) {
            // A single attached supply does not identify which EC rating is
            // current: the other register may retain a detached brick's value.
            data.validMask=0;data.status=Status::Inconsistent;return false;
        }
        return true;
    }
};
}
