#!/usr/bin/env python3
"""Inspect or apply the validated one-key AirPlay VT-scaling configuration fix.

Apply/restore require root, but never request credentials or restart services.
No framework, KEXT, EFI, cache, BIOS or account is modified. The setting is
read by the root AirPlay helper when it starts a new FVDP session.
"""
import argparse
import base64
import ctypes as C
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import platform
import struct
import subprocess
import sys
import uuid

DOMAIN = "com.apple.coremedia"
KEY = "wirelessdisplay_enable_vtscaling"
DEFAULT_BACKUPS = Path("/var/root/Library/Application Support/A51m/AirPlayBackups")
P, B, I, L = C.c_void_p, C.c_ubyte, C.c_int32, C.c_long


class Preferences:
    def __init__(self, domain=DOMAIN):
        self.cf = C.CDLL("/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
        signatures = {
            "CFStringCreateWithCString": (P, [P, C.c_char_p, C.c_uint32]),
            "CFPreferencesCopyValue": (P, [P, P, P, P]),
            "CFPreferencesCopyAppValue": (P, [P, P]),
            "CFPreferencesSetValue": (None, [P, P, P, P, P]),
            "CFPreferencesSynchronize": (B, [P, P, P]),
            "CFPreferencesAppSynchronize": (B, [P]),
            "CFPreferencesGetAppBooleanValue": (B, [P, P, C.POINTER(B)]),
            "CFPreferencesAppValueIsForced": (B, [P, P]),
            "CFPropertyListCreateData": (P, [P, P, L, C.c_ulong, C.POINTER(P)]),
            "CFPropertyListCreateWithData": (P, [P, P, C.c_ulong, P, C.POINTER(P)]),
            "CFDataCreate": (P, [P, P, L]),
            "CFDataGetLength": (L, [P]),
            "CFDataGetBytePtr": (P, [P]),
            "CFRelease": (None, [P]),
        }
        for name, (restype, argtypes) in signatures.items():
            fn = getattr(self.cf, name)
            fn.restype, fn.argtypes = restype, argtypes
        self.domain = self.string(domain)
        self.key = self.string(KEY)
        self.user = P.in_dll(self.cf, "kCFPreferencesCurrentUser").value
        self.hosts = {name: P.in_dll(self.cf, symbol).value for name, symbol in (
            ("any", "kCFPreferencesAnyHost"), ("current", "kCFPreferencesCurrentHost"))}
        self.false = P.in_dll(self.cf, "kCFBooleanFalse").value
        self.true = P.in_dll(self.cf, "kCFBooleanTrue").value

    def string(self, value):
        return self.cf.CFStringCreateWithCString(None, value.encode(), 0x08000100)

    def serialize(self, value):
        if not value:
            return None
        error = P()
        data = self.cf.CFPropertyListCreateData(None, value, 100, 0, C.byref(error))
        if not data:
            raise RuntimeError("Cannot serialize existing preference; no modification made")
        raw = C.string_at(self.cf.CFDataGetBytePtr(data), self.cf.CFDataGetLength(data))
        self.cf.CFRelease(data)
        return base64.b64encode(raw).decode()

    def deserialize(self, saved):
        if saved is None:
            return None
        raw = base64.b64decode(saved, validate=True)
        if len(raw) > 65536:
            raise ValueError("Backup value too large")
        buffer = C.create_string_buffer(raw)
        data = self.cf.CFDataCreate(None, buffer, len(raw))
        error = P()
        value = self.cf.CFPropertyListCreateWithData(None, data, 0, None, C.byref(error))
        self.cf.CFRelease(data)
        if not value:
            raise ValueError("Invalid backup property list")
        return value

    def snapshot(self):
        saved = {}
        for name, host in self.hosts.items():
            value = self.cf.CFPreferencesCopyValue(self.key, self.domain, self.user, host)
            saved[name] = self.serialize(value)
            if value:
                self.cf.CFRelease(value)
        return saved

    def restore(self, saved):
        if set(saved) != set(self.hosts):
            raise ValueError("Backup scopes differ from the fixed preference scopes")
        # Parse both values before changing either scope.
        values = {name: self.deserialize(saved[name]) for name in self.hosts}
        try:
            for name, host in self.hosts.items():
                self.cf.CFPreferencesSetValue(self.key, values[name], self.domain, self.user, host)
            self.sync()
        finally:
            for value in values.values():
                if value:
                    self.cf.CFRelease(value)

    def sync(self):
        for host in self.hosts.values():
            if not self.cf.CFPreferencesSynchronize(self.domain, self.user, host):
                raise RuntimeError("Preference synchronization failed")
        if not self.cf.CFPreferencesAppSynchronize(self.domain):
            raise RuntimeError("Application preference synchronization failed")

    def effective(self):
        valid = B()
        value = self.cf.CFPreferencesGetAppBooleanValue(self.key, self.domain, C.byref(valid))
        return {"valid_boolean": bool(valid.value), "value": bool(value) if valid.value else None,
                "forced": bool(self.cf.CFPreferencesAppValueIsForced(self.key, self.domain))}


def authenticate_frameworks():
    if platform.system() != "Darwin" or platform.machine() != "x86_64":
        raise RuntimeError("This repair is validated only for this Intel macOS build")
    system = C.CDLL("/usr/lib/libSystem.B.dylib")
    system._dyld_image_count.restype = C.c_uint32
    system._dyld_get_image_name.argtypes = [C.c_uint32]
    system._dyld_get_image_name.restype = C.c_char_p
    system._dyld_get_image_header.argtypes = [C.c_uint32]
    system._dyld_get_image_header.restype = P
    required = {
        "MediaToolbox": ("0d6c8be066d83a10a9cb1bde0ba2d785", 0x3A1C20, 106,
                         "d8861b10b7a8cf287382ee21d9ffd9d471234cc97a6cf5f99e1384a047f5972c"),
        "VideoToolbox": ("e7231bea63883d0a95c0a93ce970b96b", 0x46D0E4, 481,
                         "67741178719a35f4a4323c88dee8f23a78299a7aa378734a058b91756bdcf3d2"),
    }
    libraries = [C.CDLL("/System/Library/Frameworks/%s.framework/%s" % (name, name))
                 for name in required]
    actual = {}
    for i in range(system._dyld_image_count()):
        name = (system._dyld_get_image_name(i) or b"").decode().rsplit("/", 1)[-1]
        if name not in required:
            continue
        base = system._dyld_get_image_header(i)
        header = struct.unpack("<8I", C.string_at(base, 32))
        commands, cursor, image_uuid = C.string_at(base + 32, header[5]), 0, None
        for _ in range(header[4]):
            command, length = struct.unpack_from("<II", commands, cursor)
            if command == 0x1B:
                image_uuid = commands[cursor + 8:cursor + 24].hex()
            cursor += length
        expected_uuid, offset, size, sha = required[name]
        if image_uuid != expected_uuid or hashlib.sha256(C.string_at(base + offset, size)).hexdigest() != sha:
            raise RuntimeError("Unvalidated %s version; refusing configuration change" % name)
        if name == "MediaToolbox":
            # Authenticate the per-session preference branch and its complete
            # native wrapper, not only the global GPU capability probe.
            # A same-process four-session test verifies this is not once-only.
            for start, length, digest in (
                (0x5107F5, 58, "63bbca925cc1d74a8aba070d5b8991c775745a424e9100092bb87b9219f3a53e"),
                (0x5ADC51, 48, "6f09a60183c8baddda50a9994fb39a621bd66715536b4f561bcd464b33198dfb"),
            ):
                if hashlib.sha256(C.string_at(base + start, length)).hexdigest() != digest:
                    raise RuntimeError("Unvalidated AirPlay preference reader; no change made")
        actual[name] = image_uuid
    if set(actual) != set(required):
        raise RuntimeError("Required framework not found")
    return actual


def require_root():
    if os.geteuid() != 0:
        raise SystemExit("Root is required for the root AirPlay helper preference; no change made")


def fresh_status():
    result = subprocess.run([sys.executable, "-I", str(Path(__file__).resolve()), "--inspect"],
                            check=True, capture_output=True, text=True, timeout=10)
    return json.loads(result.stdout)


def apply(args):
    require_root()
    images = authenticate_frameworks()
    preferences = Preferences()
    before = preferences.snapshot()
    effective = preferences.effective()
    if effective["forced"]:
        raise SystemExit("A managed policy controls this key; no change made")
    args.backup_dir.mkdir(parents=True, exist_ok=True)
    filename = args.backup_dir / (dt.datetime.now(dt.timezone.utc).strftime("%Y%m%dT%H%M%SZ") + "-" + uuid.uuid4().hex[:8] + ".json")
    record = {"schema": 1, "domain": DOMAIN, "key": KEY, "uid": 0,
              "created_utc": dt.datetime.now(dt.timezone.utc).isoformat(),
              "frameworks": images, "before": before, "effective_before": effective}
    record["expected_after"] = {"any": preferences.serialize(preferences.false),
                                "current": preferences.serialize(preferences.false)
                                if before["current"] is not None else None}
    with os.fdopen(os.open(filename, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW, 0o600), "w") as file:
        json.dump(record, file, indent=2)
        file.write("\n")
        file.flush()
        os.fsync(file.fileno())
    try:
        preferences.cf.CFPreferencesSetValue(preferences.key, preferences.false, preferences.domain,
                                           preferences.user, preferences.hosts["any"])
        # Preserve host-specific absence; override an existing higher-priority value.
        if before["current"] is not None:
            preferences.cf.CFPreferencesSetValue(preferences.key, preferences.false, preferences.domain,
                                               preferences.user, preferences.hosts["current"])
        preferences.sync()
        status = fresh_status()
        if status["uid"] != 0 or not status["effective"]["valid_boolean"] or status["effective"]["value"] is not False:
            raise RuntimeError("Fresh process did not read the requested boolean false")
    except Exception:
        preferences.restore(before)
        raise
    print(json.dumps({"applied": True, "domain": DOMAIN, "key": KEY, "value": False,
                      "backup": str(filename), "verification": status,
                      "restart_required": False, "affects": "new AirPlay FVDP sessions"}, indent=2))


def restore(args):
    require_root()
    if args.restore.stat().st_size > 150000:
        raise SystemExit("Unexpected backup size")
    record = json.loads(args.restore.read_text())
    if (record.get("schema"), record.get("domain"), record.get("key"), record.get("uid")) != (1, DOMAIN, KEY, 0):
        raise SystemExit("Backup does not match the fixed domain/key/root scope")
    preferences = Preferences()
    if preferences.snapshot() != record.get("expected_after"):
        raise SystemExit("Preference changed after repair; refusing to overwrite it")
    preferences.restore(record["before"])
    if preferences.snapshot() != record["before"]:
        raise RuntimeError("Restored scopes did not match the backup")
    print(json.dumps({"restored": True, "backup": str(args.restore), "verification": fresh_status()}, indent=2))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--inspect", action="store_true", help="Read this effective UID's value only (default)")
    group.add_argument("--preflight", action="store_true", help="Read-only framework UUID/hash check")
    group.add_argument("--apply", action="store_true", help="Back up and disable VT scaling for root")
    group.add_argument("--restore", type=Path, help="Restore the exact one-key scopes from a backup")
    parser.add_argument("--backup-dir", type=Path, default=DEFAULT_BACKUPS)
    args = parser.parse_args()
    if args.preflight:
        print(json.dumps({"validated_frameworks": authenticate_frameworks(), "changes": False}, indent=2))
    elif args.apply:
        apply(args)
    elif args.restore:
        restore(args)
    else:
        print(json.dumps({"uid": os.geteuid(), "domain": DOMAIN, "key": KEY,
                          "effective": Preferences().effective(), "changes": False}, indent=2))


if __name__ == "__main__":
    main()
