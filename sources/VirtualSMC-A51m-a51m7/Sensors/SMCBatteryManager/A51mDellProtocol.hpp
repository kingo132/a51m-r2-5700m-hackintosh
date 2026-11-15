// A51m read-only Dell LegacyDiags wire format. No hardware access in this file.
// The ACPI WMDM method owns SMM buffers and serialization, not this caller.
#ifndef A51M_DELL_PROTOCOL_HPP
#define A51M_DELL_PROTOCOL_HPP
#include <stdint.h>
#include <stddef.h>

namespace A51mDell {
constexpr uint32_t Schema = 2;
constexpr uint32_t DiagMagic = 0x44494147;
constexpr uint32_t DellMagic = 0x44454c4c;
constexpr size_t MaxPayload = 256;
constexpr size_t MaxPacket = 28 + MaxPayload;

enum class Field : uint8_t {
    ManufacturerAccess=0x00, Mode=0x03, Temperature=0x08, Voltage=0x09,
    Current=0x0a, RelativeCharge=0x0d, RemainingCapacity=0x0f,
    FullCapacity=0x10, Status=0x16, Cycles=0x17, DesignCapacity=0x18,
    DesignVoltage=0x19, Specification=0x1a, ManufactureDate=0x1b,
    SerialNumber=0x1c, BattmanCapability=0x2d
};

constexpr Field NumericFields[] = {
    Field::Cycles, Field::Temperature, Field::Mode, Field::DesignVoltage,
    Field::Voltage, Field::Current, Field::RelativeCharge, Field::RemainingCapacity,
    Field::FullCapacity, Field::DesignCapacity, Field::Specification,
    Field::ManufactureDate, Field::SerialNumber, Field::ManufacturerAccess,
    Field::Status, Field::BattmanCapability
};
constexpr size_t NumericCount = sizeof(NumericFields)/sizeof(NumericFields[0]);

inline uint32_t get32(const uint8_t *p) {
    return uint32_t(p[0]) | uint32_t(p[1])<<8 | uint32_t(p[2])<<16 | uint32_t(p[3])<<24;
}
inline void put32(uint8_t *p, uint32_t v) {
    for (unsigned i=0;i<4;++i) p[i]=uint8_t(v>>(8*i));
}
inline bool readFieldAllowed(uint8_t command) {
    for (auto f : NumericFields) if (uint8_t(f)==command) return true;
    return false;
}

struct Packet {
    uint8_t bytes[MaxPacket] {};
    uint32_t size {0};
    uint32_t payloadSize {0};

    // Four CIM byte-array fields, each preceded by its 32-bit byte length.
    bool prepare(uint32_t eax, uint32_t ebx, uint32_t ecx,
                 uint32_t payload, bool diagMarker) {
        if (payload!=4 && payload!=32 && payload!=256) return false;
        for (auto &b : bytes) b=0;
        put32(bytes,4); put32(bytes+4,eax);
        put32(bytes+8,4); put32(bytes+12,ebx);
        put32(bytes+16,4); put32(bytes+20,ecx);
        put32(bytes+24,payload);
        payloadSize=payload; size=28+payload;
        if (payload>4) {
            const char *marker=diagMarker ? "DELLDIAG" : "DELLCODE";
            for (uint32_t i=0;i<payload;++i) bytes[28+i]=uint8_t(marker[i%8]);
        }
        return true;
    }
    bool signature() {return prepare(0xfea3,0x0141,0,4,false);}
    bool number(Field field, uint8_t location, bool diagMarker) {
        if (location!=1 || !readFieldAllowed(uint8_t(field))) return false;
        return prepare(0x21a3,(uint32_t(uint8_t(field))<<8)|location,32,32,diagMarker);
    }
    bool string(uint8_t command, uint8_t location, bool diagMarker) {
        if (location!=1 || !(command==0x20 || command==0x21 || command==0x22 ||
                            command==0x23 || command==0x37)) return false;
        const uint32_t length=command==0x37 ? 256 : 32;
        return prepare(0x23a3,(uint32_t(command)<<8)|location,length,length,diagMarker);
    }
    bool adapter(uint8_t selector) {
        if (selector>6) return false;
        return prepare(0x24a3,uint32_t(selector)<<8,0,4,false);
    }
};

struct Reply {
    uint32_t eax {0}, ebx {0}, ecx {0};
    uint32_t payloadSize {0};
    uint8_t payload[MaxPayload] {};
};

inline bool decode(const uint8_t *bytes, size_t size, uint32_t expectedPayload, Reply &out) {
    if (!bytes || (expectedPayload!=4 && expectedPayload!=32 && expectedPayload!=256) ||
        size!=28+expectedPayload || get32(bytes)!=4 || get32(bytes+8)!=4 ||
        get32(bytes+16)!=4 || get32(bytes+24)!=expectedPayload) return false;
    Reply parsed {};
    parsed.eax=get32(bytes+4); parsed.ebx=get32(bytes+12); parsed.ecx=get32(bytes+20);
    parsed.payloadSize=expectedPayload;
    for (uint32_t i=0;i<expectedPayload;++i) parsed.payload[i]=bytes[28+i];
    out=parsed;
    return true;
}

inline bool validSignature(const Reply &r) {
    return r.payloadSize==4 && r.eax==DiagMagic && get32(r.payload)==DellMagic;
}
inline bool wordValue(const Reply &r, uint32_t requestAx, uint16_t &out) {
    // Echoed request means the interface did not execute the query.
    if (r.eax==requestAx || (r.eax&0xffffU)==0xffffU || (r.eax&0xffffU)==0xfffeU)
        return false;
    out=uint16_t(r.eax);
    return true;
}
inline bool validTemperature(uint16_t dk) {return dk>=2000 && dk<=4000;}
inline bool validDate(uint16_t date) {
    unsigned year=1980+(date>>9), month=(date>>5)&15, day=date&31;
    if (year<1980 || year>2100 || month<1 || month>12 || day<1) return false;
    const unsigned days[]={31,28,31,30,31,30,31,31,30,31,30,31};
    unsigned max=days[month-1]+(month==2 && year%4==0 && (year%100!=0 || year%400==0));
    return day<=max;
}

// A declared capacity mode is retained even if it disagrees with _BIX. No
// silent replacement of working ACPI capacities or current is allowed.
inline bool capacityMah(uint16_t raw, uint16_t mode, uint16_t designMv, uint32_t &out) {
    if (raw==0xffff || raw==0xfffe || !raw) return false;
    if (mode&0x8000U) {
        if (designMv<5000 || designMv>30000) return false;
        out=uint32_t(uint64_t(raw)*10000/designMv); // SBS energy mode is 10 mWh.
    } else out=raw;
    return true;
}
}
#endif
