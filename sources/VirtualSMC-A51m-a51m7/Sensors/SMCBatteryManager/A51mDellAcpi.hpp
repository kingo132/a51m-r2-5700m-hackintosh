// Read-only Dell LegacyDiags client. Uses firmware-owned WMDM serialization,
// validates the advertised GUID, and never writes an SMI port or physical RAM.
#ifndef A51M_DELL_ACPI_HPP
#define A51M_DELL_ACPI_HPP
#include "A51mDellTelemetry.hpp"
#include <IOKit/acpi/IOACPIPlatformDevice.h>
#include <Headers/kern_time.hpp>

namespace A51mDell {
class AcpiReader {
    bool attempted {false}, stopped {false}, adapterRefreshNeeded {true};
    uint64_t lastDynamicNs {0}, lastStaticNs {0}, lastAttemptNs {0};
    // F1DDEE52-063C-4784-A11E-8A06684B9B01, method ID DM.
    static bool descriptor(const uint8_t *p,size_t n) {
        static const uint8_t guid[]={0x52,0xee,0xdd,0xf1,0x3c,0x06,0x84,0x47,
                                    0xa1,0x1e,0x8a,0x06,0x68,0x4b,0x9b,0x01};
        if (!p || !n || n>4096 || n%20) return false;
        for(size_t i=0;i<n;i+=20) {
            bool same=true;
            for(size_t j=0;j<16;++j) if(p[i+j]!=guid[j]) same=false;
            if(same && p[i+16]=='D' && p[i+17]=='M' && p[i+18]>=1 &&
               (p[i+19]&0x02)!=0) return true;
        }
        return false;
    }
    IOACPIPlatformDevice *findEndpoint() {
        auto iter=IORegistryIterator::iterateOver(gIOACPIPlane,kIORegistryIterateRecursively);
        IOACPIPlatformDevice *found=nullptr;
        if (!iter) return nullptr;
        while(auto entry=iter->getNextObject()) {
            if(!entry->getName() || strcmp(entry->getName(),"DIAG")) continue;
            auto device=OSDynamicCast(IOACPIPlatformDevice,entry);
            if(device) {device->retain();found=device;break;}
        }
        iter->release();
        return found;
    }
    bool invoke(IOACPIPlatformDevice *device, const Packet &p, Reply &reply) {
        if(stopped) return false;
        auto instance=OSNumber::withNumber(uint64_t(0),32);
        auto method=OSNumber::withNumber(uint64_t(1),32);
        auto input=OSData::withBytes(p.bytes,p.size);
        bool ok=false;
        if(instance && method && input) {
            OSObject *args[]={instance,method,input}; OSObject *result=nullptr;
            uint64_t before=getCurrentTimeNs();
            auto ret=device->evaluateObject("WMDM",&result,args,3);
            uint64_t duration=(getCurrentTimeNs()-before)/1000;
            ++data.requests;
            if(duration>data.maxDurationUs)
                data.maxDurationUs=duration>UINT32_MAX ? UINT32_MAX : uint32_t(duration);
            if(ret==kIOReturnSuccess) {
                auto buffer=OSDynamicCast(OSData,result);
                if(buffer) ok=decode(static_cast<const uint8_t*>(buffer->getBytesNoCopy()),
                                    buffer->getLength(),p.payloadSize,reply);
            }
            if(result) result->release();
            // Cannot interrupt firmware execution. This prevents repeated slow
            // calls after returning; it is not a watchdog or an SMM timeout.
            if(duration>20000) {stopped=true;data.status=Status::SlowTransport;ok=false;}
        }
        if(instance) instance->release();
        if(method) method->release();
        if(input) input->release();
        if(!ok) ++data.failures;
        return ok;
    }
    bool readWord(IOACPIPlatformDevice *endpoint,Field field,bool marker) {
        Packet p; Reply reply; uint16_t value=0;
        data.valid&=~(uint64_t(1)<<uint8_t(field));
        if(!p.number(field,1,marker) || !invoke(endpoint,p,reply) ||
           !wordValue(reply,0x21a3,value)) return false;
        if(field==Field::Temperature && !validTemperature(value)) return false;
        if(field==Field::ManufactureDate && !validDate(value)) return false;
        if(field==Field::RelativeCharge && value>100) return false;
        if((field==Field::Voltage || field==Field::DesignVoltage) &&
           (value<5000 || value>30000)) return false;
        data.set(field,value);
        return true;
    }
public:
    Telemetry data {};
    void adapterChanged() {
        // Called by the existing ACPI power-source notification path, never
        // by an extra timer. Do not retain a removed supply's valid metadata.
        adapterRefreshNeeded=true;data.adapterValid=0;data.adapterSampledNs=0;
        lastDynamicNs=0;++data.sequence;
    }
    void resume() {
        // Keep immutable identity/design data for this installed battery;
        // refresh the live cycle/temperature fields and recheck the interface.
        lastDynamicNs=0;attempted=false;
        data.valid&=~((uint64_t(1)<<uint8_t(Field::Cycles)) |
                      (uint64_t(1)<<uint8_t(Field::Temperature)));
        adapterChanged();
        ++data.sequence;
    }
    void invalidate() {
        // A disconnected battery's identity/measurements must not be reused.
        auto seq=data.sequence;
        data=Telemetry{};data.sequence=seq+1;
        lastDynamicNs=lastStaticNs=0;
        adapterRefreshNeeded=true;
        attempted=false;
        if(stopped) data.status=Status::SlowTransport;
    }
    bool refresh(bool enabled, bool liveAdapter=false) {
        if(!enabled) return false;
        if(stopped) return false;
        uint64_t now=getCurrentTimeNs();
        // The optional native rating bridge also handles same-presence AC
        // notifications. Coalesce notification storms, without retaining valid
        // removed-adapter metadata while the refresh is deferred.
        if(liveAdapter && lastAttemptNs && now-lastAttemptNs<1000000000ULL) return false;
        if(lastDynamicNs && now-lastDynamicNs<60000000000ULL) return false;
        // A missing/invalid endpoint is not retried indefinitely.
        if(attempted && data.status!=Status::Active) return false;
        attempted=true;lastDynamicNs=lastAttemptNs=now;
        // Avoid a periodic burst of dozens of SMIs. Immutable metadata and
        // comparison fields are acquired once per attachment; ordinary live
        // current/voltage/capacity continue to come from existing ACPI reads.
        bool full=!lastStaticNs;
        auto endpoint=findEndpoint();
        if(!endpoint) {data.status=Status::NoEndpoint;++data.sequence;return false;}
        bool eligible=false;OSObject *object=nullptr;
        if(endpoint->evaluateObject("_WDG",&object)==kIOReturnSuccess) {
            auto buffer=OSDynamicCast(OSData,object);
            eligible=buffer && descriptor(static_cast<const uint8_t*>(buffer->getBytesNoCopy()),buffer->getLength());
        }
        if(object) object->release();
        if(!eligible || endpoint->validateObject("WMDM")!=kIOReturnSuccess) {
            data.status=Status::InvalidDescriptor;endpoint->release();++data.sequence;return false;
        }
        Packet signature;Reply reply;signature.signature();
        if(!invoke(endpoint,signature,reply) || !validSignature(reply)) {
            if(!stopped) data.status=Status::BadSignature;
            endpoint->release();++data.sequence;return false;
        }
        data.specVersion=reply.ecx;
        bool marker=reply.ecx<=0x147;
        data.status=Status::Active;
        for(size_t i=0;i<(full ? NumericCount : 2);++i) {
            if(stopped) break;
            readWord(endpoint,NumericFields[i],marker);
        }
        if((full || adapterRefreshNeeded || liveAdapter) && !stopped) {
            data.adapterValid=0;
            // Numeric read-only adapter selectors: ID, voltage, current,
            // available design power, manufacturing date, serial, static design power.
            for(uint8_t i=0;i<7 && !stopped;++i) {
                Packet packet;Reply response;uint16_t value;
                if(packet.adapter(i) && invoke(endpoint,packet,response) &&
                   wordValue(response,0x24a3,value)) {
                    if((i==3 || i==6) && (!value || value>3000)) continue;
                    if(i==4 && !validDate(value)) continue;
                    data.adapterAx[i]=value;data.adapterBx[i]=uint16_t(response.ebx);
                    data.adapterValid|=1U<<i;
                }
            }
            data.adapterSampledNs=now;adapterRefreshNeeded=false;
        }
        if(full && !stopped) {
            data.stringValid=0;
            const uint8_t commands[]={0x20,0x21,0x22,0x23,0x37};
            for(size_t i=0;i<5 && !stopped;++i) {
                Packet packet;Reply response;uint16_t result;
                if(packet.string(commands[i],1,marker) && invoke(endpoint,packet,response) &&
                   wordValue(response,0x23a3,result) && result>0 && result<=packet.payloadSize) {
                    // An echoed initialization marker is not returned data.
                    bool changed=false;
                    for(uint32_t j=0;j<packet.payloadSize;++j)
                        if(response.payload[j]!=packet.bytes[28+j]) changed=true;
                    if(!changed) continue;
                    for(size_t j=0;j<256;++j) data.strings[i][j]=response.payload[j];
                    data.stringLength[i]=result;
                    data.stringValid|=1U<<i;
                }
            }
            lastStaticNs=now;data.staticSampledNs=now;
        }
        endpoint->release();data.sampledNs=now;++data.sequence;
        return data.status==Status::Active;
    }
};
}
#endif
