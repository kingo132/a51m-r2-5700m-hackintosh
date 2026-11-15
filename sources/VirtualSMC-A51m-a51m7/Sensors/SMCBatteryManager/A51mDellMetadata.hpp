// Mapping policy shared by the kernel integration and hardware-free tests.
#ifndef A51M_DELL_METADATA_HPP
#define A51M_DELL_METADATA_HPP
#include "A51mDellTelemetry.hpp"

namespace A51mDell {
template <class Battery> void applyMetadata(const Telemetry &raw, Battery &info) {
    info.a51mDellInfo=raw;
    if(raw.status!=Status::Active) return;
    if(raw.has(Field::Cycles)) info.cycle=raw.numeric[0x17];
    if(raw.has(Field::ManufactureDate) && validDate(raw.numeric[0x1b]))
        info.manufactureDate=raw.numeric[0x1b];
    if(raw.has(Field::SerialNumber))
        snprintf(info.serial,sizeof(info.serial),"%u",unsigned(raw.numeric[0x1c]));
    if(raw.has(Field::Temperature) && validTemperature(raw.numeric[0x08])) {
        info.state.temperatureDecikelvin=raw.numeric[0x08];
        info.state.temperature=(double(raw.numeric[0x08])-2731.5)/10.0;
        info.state.publishTemperatureKey=true;
    }
    char *destinations[]={info.manufacturer,info.deviceName,info.batteryType};
    for(size_t n=0;n<3;++n) {
        if(!(raw.stringValid&(1U<<n)) || raw.stringLength[n]>sizeof(raw.strings[n])) continue;
        char text[Battery::MaxStringLen] {};size_t pos=0;bool printable=true;
        for(size_t i=0;i<raw.stringLength[n];++i) {
            auto c=raw.strings[n][i];
            if(!c) continue;
            if(c<0x20 || c>0x7e) {printable=false;break;}
            if(pos+1<sizeof(text)) text[pos++]=char(c);
        }
        if(printable && pos) {
            for(size_t i=0;i<Battery::MaxStringLen;++i) destinations[n][i]=text[i];
        }
    }
    // Never substitute Dell capacity mode for the working _BIX units, change
    // _BST current/voltage, or change firmware charging thresholds here.
}
}
#endif
