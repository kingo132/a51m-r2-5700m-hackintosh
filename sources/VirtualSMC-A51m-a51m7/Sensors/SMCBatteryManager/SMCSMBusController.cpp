//
//  SMCSMBusController.cpp
//  SMCBatteryManager
//
//  Copyright © 2018 usrsse2. All rights reserved.
//

#include <Headers/kern_compat.hpp>
#include <Headers/kern_api.hpp>
#include <stdatomic.h>
#include <Headers/kern_time.hpp>

#include <libkern/c++/OSContainers.h>
#include <IOKit/IOCatalogue.h>
#include <IOKit/IOTimerEventSource.h>

#include "SMCSMBusController.hpp"
#include "A51mBatteryRevision.hpp"

extern _Atomic(bool) smc_battery_manager_started;

OSDefineMetaClassAndStructors(SMCSMBusController, IOSMBusController)

bool SMCSMBusController::init(OSDictionary *properties) {
	if (!IOSMBusController::init(properties)) {
		SYSLOG("smcbus", "parent initialisation failure");
		return false;
	}

	return true;
}

void SMCSMBusController::free() {
	delete a51mObserver;
	a51mObserver = nullptr;
	IOSMBusController::free();
}

IOService *SMCSMBusController::probe(IOService *provider, SInt32 *score) {
	if (!IOSMBusController::probe(provider, score)) {
		SYSLOG("smcbus", "parent probe failure");
		return nullptr;
	}

	if (!BatteryManager::getShared()->probe()) {
		SYSLOG("smcbus", "BatteryManager probe failure");
		return nullptr;
	}

	return this;
}

bool SMCSMBusController::start(IOService *provider) {
	
	if (!smc_battery_manager_started) {
		DBGLOG("smcbus", "SMCBatteryManager is not available now, will check during next start attempt");
		return false;
	}
	
	DBGLOG("smcbus", "SMCBatteryManager is available, start SMCSMBusController");
	
	workLoop = IOWorkLoop::workLoop();
	if (!workLoop) {
		SYSLOG("smcbus", "createWorkLoop allocation failed");
		return false;
	}

	requestQueue = OSArray::withCapacity(0);
	if (!requestQueue) {
		SYSLOG("smcbus", "requestQueue allocation failure");
		OSSafeReleaseNULL(workLoop);
		return false;
	}
	
	if (!IOSMBusController::start(provider)) {
		SYSLOG("smcbus", "parent start failed");
		OSSafeReleaseNULL(workLoop);
		OSSafeReleaseNULL(requestQueue);
		return false;
	}

	setProperty("IOSMBusSmartBatteryManager", kOSBooleanTrue);
	setProperty("A51mBatteryRevision", A51mBattery::Revision);
	setProperty("A51mBatteryTimePolicyEnabled", BatteryManager::getShared()->a51mTimePolicyEnabled);
	setProperty("A51mDellTelemetryEnabled", BatteryManager::getShared()->a51mDellEnabled);
	if (BatteryManager::getShared()->a51mObserveEnabled)
		a51mObserver = new A51mObserver;
	setProperty("A51mBatteryObserveActive", a51mObserver != nullptr);
	setProperty("_SBS", 1, 32);
	registerService();

	timer = IOTimerEventSource::timerEventSource(this,
	[](OSObject *owner, IOTimerEventSource *) {
		auto ctrl = OSDynamicCast(SMCSMBusController, owner);
		if (ctrl) {
			ctrl->handleBatteryCommandsEvent();
		} else {
			SYSLOG("smcbus", "invalid owner passed to handleBatteryCommandsEvent");
		}
	});

	if (timer) {
		getWorkLoop()->addEventSource(timer);
		timer->setTimeoutMS(TimerTimeoutMs);
	} else {
		SYSLOG("smcbus", "failed to allocate normal timer event");
		OSSafeReleaseNULL(workLoop);
		OSSafeReleaseNULL(requestQueue);
		return false;
	}

	BatteryManager::getShared()->start();
	
	PMinit();
	provider->joinPMtree(this);
	registerPowerDriver(this, smbusPowerStates, arrsize(smbusPowerStates));

	BatteryManager::getShared()->subscribe(handleACPINotification, this);
	
	return true;
}

void SMCSMBusController::stop(IOService *) {
	PANIC("smcbus", "called stop!!!");
}

void SMCSMBusController::setReceiveData(IOSMBusTransaction *transaction, uint16_t valueToWrite) {
	transaction->receiveDataCount = sizeof(uint16_t);
	uint16_t *ptr = reinterpret_cast<uint16_t*>(transaction->receiveData);
	*ptr = valueToWrite;
}

IOSMBusStatus SMCSMBusController::startRequest(IOSMBusRequest *request) {
	DBGLOG("smcbus", "startRequest is called");

	auto result = IOSMBusController::startRequest(request);
	if (result != kIOSMBusStatusOK) {
		SYSLOG("smcbus", "parent startRequest failed with status = 0x%x", result);
		return result;
	}
	
	IOSMBusTransaction *transaction = request->transaction;
	A51mBattery::Snapshot replySource {};
	bool haveReplySource = false;

	if (transaction) {
		DBGLOG("smcbus", "startRequest is called, address = 0x%x, command = 0x%x, protocol = 0x%x, status = 0x%x, sendDataCount = 0x%x, receiveDataCount = 0x%x",
			   transaction->address, transaction->command, transaction->protocol, transaction->status, transaction->sendDataCount, transaction->receiveDataCount);

		transaction->status = kIOSMBusStatusOK;
		uint32_t valueToWrite = 0;
		
		if (transaction->address == kSMBusManagerAddr && transaction->protocol == kIOSMBusProtocolReadWord) {
			switch (transaction->command) {
				case kMStateContCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					valueToWrite = BatteryManager::getShared()->externalPowerConnected() ? kMACPresentBit : 0;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, valueToWrite);
					break;
				}
				case kMStateCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					if (BatteryManager::getShared()->batteriesConnected()) {
						valueToWrite = kMPresentBatt_A_Bit;
						if ((BatteryManager::getShared()->state.btInfo[0].state.state & ACPIBattery::BSTStateMask) == ACPIBattery::BSTCharging)
							valueToWrite |= kMChargingBatt_A_Bit;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, valueToWrite);
					break;
				}
				default: {
					// Nothing should be done here since AppleSmartBattery always calls bzero fo transaction
					// Let's also not set transaction status to error value since it can be an unknown command
					break;
				}
			}
		}

		if (transaction->address == kSMBusBatteryAddr && transaction->protocol == kIOSMBusProtocolReadWord) {
			//FIXME: maybe the incoming data show us which battery is queried about? Or it's in the address?

			switch (transaction->command) {
				case kBBatteryStatusCmd: {
					setReceiveData(transaction, BatteryManager::getShared()->calculateBatteryStatus(0));
					break;
				}
				case kBManufacturerAccessCmd: {
					if (transaction->sendDataCount == 2 &&
						(transaction->sendData[0] == kBExtendedPFStatusCmd ||
						 transaction->sendData[0] == kBExtendedOperationStatusCmd)) {
						// AppleSmartBatteryManager ignores these values.
						setReceiveData(transaction, 0);
					}
					//CHECKME: Should else case be handled?
					break;
				}
				case kBPackReserveCmd:
				case kBDesignCycleCount9CCmd: {
					setReceiveData(transaction, 1000);
					break;
				}
				case kBReadCellVoltage1Cmd:
				case kBReadCellVoltage2Cmd:
				case kBReadCellVoltage3Cmd:
				case kBReadCellVoltage4Cmd: {
					setReceiveData(transaction, defaultBatteryCellVoltage);
					break;
				}
				case kBCurrentCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.signedPresentRate;
					if (a51mObserver) {
						replySource = BatteryManager::getShared()->state.btInfo[0].a51mSnapshot;
						haveReplySource = true;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBAverageCurrentCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.signedAverageRate;
					if (a51mObserver) {
						replySource = BatteryManager::getShared()->state.btInfo[0].a51mSnapshot;
						haveReplySource = true;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBSerialNumberCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					const auto &raw=BatteryManager::getShared()->state.btInfo[0].a51mDellInfo;
					if(raw.status==A51mDell::Status::Active && raw.has(A51mDell::Field::SerialNumber))
						setReceiveData(transaction,raw.numeric[0x1c]);
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					break;
				}
				case kBMaxErrorCmd:
					break;
				case kBRunTimeToEmptyCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.runTimeToEmpty;
					if (a51mObserver) {
						replySource = BatteryManager::getShared()->state.btInfo[0].a51mSnapshot;
						haveReplySource = true;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBAverageTimeToEmptyCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.averageTimeToEmpty;
					if (a51mObserver) {
						replySource = BatteryManager::getShared()->state.btInfo[0].a51mSnapshot;
						haveReplySource = true;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBVoltageCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.presentVoltage;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBTemperatureCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.temperatureDecikelvin;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBDesignCapacityCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].designCapacity;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBCycleCountCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].cycle;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBAverageTimeToFullCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.timeToFull;
					if (a51mObserver) {
						replySource = BatteryManager::getShared()->state.btInfo[0].a51mSnapshot;
						haveReplySource = true;
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBRemainingCapacityCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.remainingCapacity;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBFullChargeCapacityCmd: {
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					auto value = BatteryManager::getShared()->state.btInfo[0].state.lastFullChargeCapacity;
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					setReceiveData(transaction, value);
					break;
				}
				case kBManufactureDateCmd: {
					uint16_t value = 0;
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					if (BatteryManager::getShared()->state.btInfo[0].manufactureDate) {
						value = BatteryManager::getShared()->state.btInfo[0].manufactureDate;
					} else {
						lilu_os_strncpy(reinterpret_cast<char *>(transaction->receiveData), BatteryManager::getShared()->state.btInfo[0].serial, kSMBusMaximumDataSize);
						transaction->receiveData[kSMBusMaximumDataSize-1] = '\0';
					}
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);

					if (!value) {
						const char* p = reinterpret_cast<char *>(transaction->receiveData);
						bool found = false;
						int year = 2016, month = 02, day = 29;
						while ((p = strstr(p, "20")) != nullptr) { // hope that this code will not survive until 22nd century
							if (sscanf(p, "%04d%02d%02d", &year, &month, &day) == 3 || 		// YYYYMMDD (Lenovo)
								sscanf(p, "%04d/%02d/%02d", &year, &month, &day) == 3) {	// YYYY/MM/DD (HP)
								if (1 <= month && month <= 12 && 1 <= day && day <= 31) {
									found = true;
									break;
								}
							}
							p++;
						}
						
						if (!found) { // in case we parsed a non-date
							year = 2016;
							month = 02;
							day = 29;
						}
						value = makeBatteryDate(day, month, year);
					}
					
					setReceiveData(transaction, value);
					break;
				}
				//CHECKME: Should there be a default setting receiveDataCount to 0 or status failure?
			}
		}

		if (transaction->address == kSMBusBatteryAddr &&
			transaction->protocol == kIOSMBusProtocolWriteWord &&
			transaction->command == kBManufacturerAccessCmd) {
			if (transaction->sendDataCount == 2 && (transaction->sendData[0] == kBExtendedPFStatusCmd || transaction->sendData[0] == kBExtendedOperationStatusCmd)) {
				DBGLOG("smcbus", "startRequest sendData contains kBExtendedPFStatusCmd or kBExtendedOperationStatusCmd");
				// Nothing can be done here since we don't write any values to hardware, we fake response for this command in handler for
				// kIOSMBusProtocolReadWord/kBManufacturerAccessCmd. Anyway, AppleSmartBattery::transactionCompletion ignores this response.
				// If we can see this log statement, it means that fields sendDataCount and sendData have a proper offset in IOSMBusTransaction
			}
		}

		if (transaction->address == kSMBusBatteryAddr && transaction->protocol == kIOSMBusProtocolReadBlock) {
			switch (transaction->command) {
				case kBManufacturerNameCmd: {
					transaction->receiveDataCount = kSMBusMaximumDataSize;
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					lilu_os_strncpy(reinterpret_cast<char *>(transaction->receiveData), BatteryManager::getShared()->state.btInfo[0].manufacturer, kSMBusMaximumDataSize);
					transaction->receiveData[kSMBusMaximumDataSize-1] = '\0';
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					break;
				}
				case kBAppleHardwareSerialCmd:
					transaction->receiveDataCount = kSMBusMaximumDataSize;
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					lilu_os_strncpy(reinterpret_cast<char *>(transaction->receiveData), BatteryManager::getShared()->state.btInfo[0].serial, kSMBusMaximumDataSize);
					transaction->receiveData[kSMBusMaximumDataSize-1] = '\0';
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					break;
				case kBDeviceNameCmd:
					transaction->receiveDataCount = kSMBusMaximumDataSize;
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					lilu_os_strncpy(reinterpret_cast<char *>(transaction->receiveData), BatteryManager::getShared()->state.btInfo[0].deviceName, kSMBusMaximumDataSize);
					transaction->receiveData[kSMBusMaximumDataSize-1] = '\0';
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					break;
				case kBManufacturerDataCmd:
					transaction->receiveDataCount = sizeof(BatteryInfo::BatteryManufacturerData);
					IOSimpleLockLock(BatteryManager::getShared()->stateLock);
					lilu_os_memcpy(reinterpret_cast<uint16_t *>(transaction->receiveData), &BatteryManager::getShared()->state.btInfo[0].batteryManufacturerData, sizeof(BatteryInfo::BatteryManufacturerData));
					IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);
					break;
				case kBManufacturerInfoCmd:
					break;
				// Let other commands slip if any.
				// receiveDataCount is already 0, and status failure results in retries - it's not what we want.
			}
		}
	}

	if (!requestQueue->setObject(request)) {
		SYSLOG("smcbus", "startRequest failed to append a request");
		return kIOSMBusStatusUnknownFailure;
	}
	if (haveReplySource)
		observePrepared(request, replySource);

	IOSimpleLockLock(BatteryManager::getShared()->stateLock);
	BatteryManager::getShared()->lastAccess = getCurrentTimeNs();
	IOSimpleLockUnlock(BatteryManager::getShared()->stateLock);

	return result;
}

void SMCSMBusController::handleBatteryCommandsEvent() {
	timer->setTimeoutMS(TimerTimeoutMs);

	// requestQueue contains objects owned by two parties:
	// 1. requestQueue itself, as the addition of any object retains it
	// 2. IOSMBusController, since it does not release the object after passing it
	// to us in OSMBusController::performTransactionGated.
	// OSArray::removeObject takes away our ownership, and then
	// IOSMBusController::completeRequest releases the request inside.

	while (requestQueue->getCount() != 0) {
		auto request = OSDynamicCast(IOSMBusRequest, requestQueue->getObject(0));
		requestQueue->removeObject(0);
		if (request != nullptr) {
			observeCompletion(request);
			completeRequest(request);
		}
	}
	publishObservation();
}

// All observer methods run on the existing controller workloop, never under stateLock.
void SMCSMBusController::observePrepared(IOSMBusRequest *request, const A51mBattery::Snapshot &source) {
	if (!a51mObserver || !request->transaction)
		return;
	A51mPending *slot = nullptr;
	for (auto &pending : a51mObserver->pending) {
		if (pending.request == request) {
			++a51mObserver->trace.dropped;
			a51mObserver->dirty = true;
			return; // Do not misattribute an already outstanding pointer.
		}
		if (!pending.request && !slot)
			slot = &pending;
	}
	if (!slot) {
		++a51mObserver->trace.dropped;
		a51mObserver->dirty = true;
		return; // Bounded diagnostic; never interfere with the request queue.
	}
	auto transaction = request->transaction;
	slot->request = request;
	slot->command = transaction->command;
	slot->value = uint16_t(transaction->receiveData[0]) | (uint16_t(transaction->receiveData[1]) << 8);
	slot->source = source;
	slot->requestSequence = a51mObserver->trace.total + 1;
	A51mBattery::Record record {};
	record.eventNs = getCurrentTimeNs();
	record.phase = 1; // Prepared reply, not yet completed.
	record.command = record.expectedCommand = slot->command;
	record.value = record.expectedValue = slot->value;
	record.receiveCount = transaction->receiveDataCount;
	record.source = source;
	record.requestSequence = slot->requestSequence;
	a51mObserver->trace.append(record);
	a51mObserver->dirty = true;
}

void SMCSMBusController::observeCompletion(IOSMBusRequest *request) {
	if (!a51mObserver)
		return;
	for (auto &pending : a51mObserver->pending) {
		if (pending.request != request)
			continue;
		if (request->transaction) {
			auto transaction = request->transaction;
			A51mBattery::Record record {};
			record.eventNs = getCurrentTimeNs();
			record.phase = 2; // Immediately before native completeRequest; no read after release.
			record.command = transaction->command;
			record.value = uint16_t(transaction->receiveData[0]) | (uint16_t(transaction->receiveData[1]) << 8);
			record.receiveCount = transaction->receiveDataCount;
			record.expectedCommand = pending.command;
			record.expectedValue = pending.value;
			record.source = pending.source;
			record.requestSequence = pending.requestSequence;
			a51mObserver->trace.append(record);
			a51mObserver->dirty = true;
		}
		pending.request = nullptr;
		return;
	}
}

void SMCSMBusController::publishObservation() {
	auto &manager = *BatteryManager::getShared();
	if(manager.a51mDellEnabled) {
		A51mDell::Telemetry raw {};
		A51mDualAdapter::Telemetry dual {};
		IOSimpleLockLock(manager.stateLock);
		raw=manager.state.btInfo[0].a51mDellInfo;
		dual=manager.state.btInfo[0].a51mDualAdapterInfo;
		IOSimpleLockUnlock(manager.stateLock);
		if(raw.sequence!=a51mLastDellSequence) {
			auto data=OSData::withBytes(&raw,sizeof(raw));
			if(data) {
				setProperty("A51mDellTelemetry",data);
				setProperty("A51mDellTelemetrySchema",A51mDell::Schema,32);
				data->release();
				a51mLastDellSequence=raw.sequence;
			}
		}
		if(dual.sequence!=a51mLastDualAdapterSequence) {
			auto data=OSData::withBytes(&dual,sizeof(dual));
			if(data) {
				setProperty("A51mDualAdapterTelemetry",data);
				data->release();
				a51mLastDualAdapterSequence=dual.sequence;
			}
		}
	}
	if (!a51mObserver || !a51mObserver->dirty)
		return;
	// Copy under the existing state lock; allocate/publish only after unlocking.
	A51mBattery::StaticInfo raw {};
	IOSimpleLockLock(manager.stateLock);
	raw = manager.state.btInfo[0].a51mStaticInfo;
	IOSimpleLockUnlock(manager.stateLock);
	if (raw.method) {
		auto staticData = OSData::withBytes(&raw, sizeof(raw));
		if (staticData) {
			setProperty("A51mBatteryStaticInfo", staticData);
			setProperty("A51mBatteryStaticInfoSchema", 1, 32);
			staticData->release();
		}
	}
	auto data = OSData::withBytes(&a51mObserver->trace, sizeof(a51mObserver->trace));
	if (data) {
		setProperty("A51mBatteryTrace", data);
		data->release();
		a51mObserver->dirty = false;
	}
}

IOReturn SMCSMBusController::handleACPINotification(void *target) {
	SMCSMBusController *self = static_cast<SMCSMBusController *>(target);
	if (self) {
		auto &bmgr = *BatteryManager::getShared();
		// TODO: when we have multiple batteries, handle insertion or removal of a single battery
		IOSimpleLockLock(bmgr.stateLock);
		bool batteriesConnected = bmgr.batteriesConnected();
		bool adaptersConnected = bmgr.adaptersConnected();
		self->prevBatteriesConnected = batteriesConnected;
		self->prevAdaptersConnected = adaptersConnected;
		IOSimpleLockUnlock(bmgr.stateLock);
		uint8_t data[] = {kBMessageStatusCmd, batteriesConnected};
		DBGLOG("smcbus", "sending kBMessageStatusCmd with data %x", data[1]);
		self->messageClients(kIOMessageSMBusAlarm, data, arrsize(data));
		return kIOReturnSuccess;
	}
	return kIOReturnBadArgument;
}

IOReturn SMCSMBusController::setPowerState(unsigned long state, IOService *device) {
	if (state) {
		DBGLOG("smcbus", "%s we are waking up", safeString(device->getName()));
		if (!BatteryManager::getShared()->quickPollDisabled)
			atomic_store_explicit(&BatteryManager::getShared()->quickPoll, ACPIBattery::QuickPollCount, memory_order_release);
		BatteryManager::getShared()->wake();
	} else {
		DBGLOG("smcbus", "%s we are sleeping", safeString(device->getName()));
		atomic_store_explicit(&BatteryManager::getShared()->quickPoll, 0, memory_order_release);
		BatteryManager::getShared()->sleep();
	}
	return kIOPMAckImplied;
}
