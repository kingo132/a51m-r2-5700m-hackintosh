#pragma once
#include "NaviTelemetryPolicy.hpp"
#include <IOKit/IOService.h>
#include <IOKit/pci/IOPCIDevice.h>
#include "NaviStatisticsCodec.hpp"
#include <Headers/kern_time.hpp>
#include <kern/thread_call.h>
namespace NaviTelemetry {
struct DictionaryReader {
    OSDictionary *dictionary;
    bool number(const char *key, uint64_t &value) {
        auto number = OSDynamicCast(OSNumber, dictionary->getObject(key));
        if (number == nullptr) return false;
        value = number->unsigned64BitValue(); return true;
    }
};
enum class Status : uint32_t { Disabled, NoAccelerator, Ambiguous, Inactive, NoStatistics, Ready, UnstableTree, InvalidSerialization };
class Cache {
    IOSimpleLock *lock {nullptr};
    thread_call_t worker {nullptr};
    IOPCIDevice *device {nullptr}; // Retained until the worker is drained.
    Snapshot committed {};
    Status committedStatus {Status::Disabled};
    uint64_t requestedNs {0};
    bool stopping {false};
    static constexpr uint64_t RefreshNs = 500000000ULL;
    static constexpr uint64_t MaxAgeNs = 2000000000ULL;
    IOService *publisher {nullptr}; // Borrowed from owner; no retain cycle.
    Snapshot sample {};
    Status status {Status::Disabled};
    uint32_t sourceKind {0}; // 0 absent, 1 direct dictionary, 2 serialized object.
    void collect(IORegistryEntry *root, unsigned depth, IOService *&accelerator, unsigned &visited) {
        // The Navi accelerator can be attached to both the PCI device and
        // its controller. Search two provider hops, deduplicate the object,
        // and never traverse hundreds of per-application accelerator clients.
        auto iterator = IORegistryIterator::iterateOver(root, gIOServicePlane, 0);
        if (!iterator) { status = Status::UnstableTree; return; }
        while (auto entry = iterator->getNextObject()) {
            if (++visited > 128) { status = Status::UnstableTree; break; }
            if (entry->metaCast("IOAccelerator")) {
                auto service = OSDynamicCast(IOService, entry);
                if (!service) continue;
                if (accelerator && service != accelerator) { status = Status::Ambiguous; break; }
                if (!accelerator) { accelerator = service; accelerator->retain(); }
            } else if (depth == 0) collect(entry, depth + 1, accelerator, visited);
            if (status == Status::Ambiguous || status == Status::UnstableTree) break;
        }
        if (!iterator->isValid()) status = Status::UnstableTree;
        iterator->release();
    }
    void publish() {
        if (!publisher) return;
        auto dictionary = OSDictionary::withCapacity(Count + 5);
        if (!dictionary) return;
        auto add = [&](const char *key, uint64_t value) {
            auto number = OSNumber::withNumber(value, 64);
            if (number != nullptr) { dictionary->setObject(key, number); number->release(); }
        };
        add("schema", 1); add("status", uint32_t(status)); add("observed_ns", sample.observedNs);
        add("valid_mask", sample.valid);
        add("source_kind", sourceKind);
        for (size_t i = 0; i < Count; ++i)
            if (sample.has(Metric(i))) add(Names[i], sample.values[i]);
        publisher->setProperty("A51mNaviTelemetry", dictionary);
        dictionary->release();
    }
    void refresh(IOPCIDevice *device, uint64_t now) {
        sample = Snapshot {}; sample.observedNs = now;
        sourceKind = 0;
        status = Status::NoAccelerator;
        // Root the search at this exact GPU, never the first system accelerator.
        IOService *accelerator = nullptr;
        unsigned visited = 0;
        collect(device, 0, accelerator, visited);
        if (accelerator && status != Status::Ambiguous && status != Status::UnstableTree) {
            if (device->isInactive() || accelerator->isInactive()) status = Status::Inactive;
            else {
                auto property = accelerator->copyProperty("PerformanceStatistics");
                sourceKind = property ? (OSDynamicCast(OSDictionary, property) ? 1 : 2) : 0;
                auto dictionary = copyStatisticsDictionary(property);
                status = dictionary ? Status::Ready : (property ? Status::InvalidSerialization : Status::NoStatistics);
                if (dictionary) {
                    DictionaryReader reader {dictionary}; sample = decode(reader, now);
                    dictionary->release();
                }
                if (property) property->release();
            }
        }
        if (accelerator) accelerator->release();
        auto interrupts = IOSimpleLockLockDisableInterrupt(lock);
        if (!stopping) { committed = sample; committedStatus = status; }
        IOSimpleLockUnlockEnableInterrupt(lock, interrupts);
        publish(); // Worker context only: registry allocation never runs in an SMC trap.
    }
    static void work(thread_call_param_t context, thread_call_param_t) {
        auto self = static_cast<Cache *>(context);
        self->refresh(self->device, getCurrentTimeNs());
    }
public:
    bool active() const { return worker != nullptr; }
    bool init(IOService *owner, IOPCIDevice *gpu) {
        if (!owner || !gpu) return false;
        publisher = owner;
        lock = IOSimpleLockAlloc();
        if (!lock) return false;
        device = gpu; device->retain();
        worker = thread_call_allocate_with_options(work, this, THREAD_CALL_PRIORITY_LOW, THREAD_CALL_OPTIONS_ONCE);
        if (!worker) { device->release(); device = nullptr; IOSimpleLockFree(lock); lock = nullptr; return false; }
        return true;
    }
    // The owning plugin refuses hot unload. Destruction requires no new reads.
    // Cancel/drain before releasing the retained GPU or borrowed publisher.
    void free() {
        if (lock) {
            auto interrupts = IOSimpleLockLockDisableInterrupt(lock);
            stopping = true;
            IOSimpleLockUnlockEnableInterrupt(lock, interrupts);
        }
        if (worker) { thread_call_cancel_wait(worker); thread_call_free(worker); worker = nullptr; }
        if (device) { device->release(); device = nullptr; }
        if (lock) { IOSimpleLockFree(lock); lock = nullptr; }
        publisher = nullptr;
    }
    bool read(IOPCIDevice *gpu, Metric metric, uint8_t *output, size_t size) {
        if (!worker || !lock || gpu != device) return false;
        auto now = getCurrentTimeNs();
        bool enqueue = false;
        Snapshot value {}; Status valueStatus;
        auto interrupts = IOSimpleLockLockDisableInterrupt(lock);
        if (stopping) { IOSimpleLockUnlockEnableInterrupt(lock, interrupts); return false; }
        if (!requestedNs || now < requestedNs || now - requestedNs >= RefreshNs) {
            requestedNs = now; enqueue = true;
        }
        value = committed; valueStatus = committedStatus;
        IOSimpleLockUnlockEnableInterrupt(lock, interrupts);
        // No registry traversal, XML parsing or native callback in readAccess.
        // A delayed worker may not make an old sample look newly observed.
        if (enqueue) thread_call_enter(worker);
        return valueStatus == Status::Ready && now >= value.observedNs &&
               now - value.observedNs <= MaxAgeNs && encode(value, metric, output, size);
    }
};
}
