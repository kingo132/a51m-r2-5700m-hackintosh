// Copyright © 2023-2024 ChefKiss. Licensed under the Thou Shalt Not Profit License version 1.5.
// See LICENSE for details.

#include "KeyImplementations.hpp"

SMC_RESULT RGPUNativeValue::readAccess() {
    auto card = provider->getCard(index);
    if (!card || !card->readNativeTelemetry(metric, data, size)) return SmcNotReadable;
    return SmcSuccess;
}

SMC_RESULT RGPUTempValue::readAccess() {
    auto card = provider->getCard(index);
    UInt16 value = 0;
    if (!card || card->getTemperature(&value) != kIOReturnSuccess || value > 127) return SmcNotReadable;
    *reinterpret_cast<UInt16 *>(this->data) = VirtualSMCAPI::encodeIntSp(this->type, value);
    return SmcSuccess;
}

SMC_RESULT RGPUPowerValue::readAccess() {
    auto value = this->provider->getPower(this->index);
    *reinterpret_cast<UInt16 *>(data) = VirtualSMCAPI::encodeSp(this->type, static_cast<double>(value));
    return SmcSuccess;
}
