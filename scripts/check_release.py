#!/usr/bin/env python3
"""Read-only release/template privacy checks. Never prints identifier values."""

import argparse
import base64
import hashlib
import json
from pathlib import Path
import plistlib
import re
import subprocess
import sys


ROOT = Path(__file__).resolve().parent.parent
IDENTITY_KEYS = {
    'mlb', 'rom', 'systemserialnumber', 'boardserialnumber',
    'chassisserialnumber', 'systemuuid', 'systemid',
}
FORBIDDEN_FLAGS = {
    '-a51mbatobserve', '-a51bklfixed16', '-a51bklprofile',
    '-a51bkllegacycurve', '-a51bkl8bit', '-a51dpcfix',
}
GPU_PATH = 'PciRoot(0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)'


def placeholder(value):
    if isinstance(value, bytes):
        return not any(value)
    return isinstance(value, str) and not value.strip().replace('0', '').replace('-', '')


def identity_findings(obj, path=''):
    found = []
    if isinstance(obj, dict):
        for key, value in obj.items():
            here = path + '/' + key
            if key.lower() in IDENTITY_KEYS and not placeholder(value):
                found.append(here)
            found.extend(identity_findings(value, here))
    elif isinstance(obj, list):
        for index, value in enumerate(obj):
            found.extend(identity_findings(value, path + '/' + str(index)))
    return found


def encoded_needles(records):
    needles = set()
    for record in records:
        if set(record) - {'kind', 'text', 'hex'} or ('text' in record) == ('hex' in record):
            raise ValueError('Invalid private identifier record')
        if 'text' in record:
            value = record['text']
            if not isinstance(value, str) or len(value) < 6:
                raise ValueError('Private text identifier must contain at least six characters')
            raw = value.encode()
            needles.update([raw.lower(), value.encode('utf-16-le').lower(),
                            value.encode('utf-16-be').lower()])
        else:
            raw = bytes.fromhex(record['hex'])
            if len(raw) < 6:
                raise ValueError('Private binary identifier must contain at least six bytes')
            needles.update([raw.lower(), raw.hex().encode(),
                            ':'.join(f'{byte:02x}' for byte in raw).encode()])
        needles.add(base64.b64encode(raw).lower())
    return needles


def contains_private(obj, needles):
    if isinstance(obj, dict):
        return any(contains_private(key, needles) or contains_private(value, needles)
                   for key, value in obj.items())
    if isinstance(obj, list):
        return any(contains_private(value, needles) for value in obj)
    raw = obj if isinstance(obj, bytes) else str(obj).encode()
    return any(needle in raw.lower() for needle in needles)


def check_candidate(path, raw, needles=()):
    errors = []
    lower = path.lower()
    if (lower.endswith(('.pftrace', '.ioreg', '.zip', '.log')) or
            'sysdiagnose' in lower or 'darwindumper' in lower or
            re.search(r'(^|/)(private|evidence|diagnostics|backups)(/|$)', lower) or
            re.search(r'(^|/)msdm\.(aml|dsl)$', lower) or
            'private-identifiers' in lower):
        errors.append('private capture/backup/license container')
    if any(needle in raw.lower() for needle in needles):
        errors.append('private identifier match')
    if lower.endswith('.plist'):
        try:
            obj = plistlib.loads(raw)
        except Exception:
            errors.append('invalid plist')
        else:
            errors.extend('populated identity field ' + key for key in identity_findings(obj))
            if needles and contains_private(obj, needles):
                errors.append('decoded plist private identifier match')
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--private-identifiers', type=Path)
    args = parser.parse_args()
    needles = ()
    if args.private_identifiers:
        # Do not echo parse errors: malformed input may itself contain private data.
        try:
            needles = encoded_needles(json.loads(args.private_identifiers.read_text()))
        except Exception:
            raise SystemExit('Private denylist could not be parsed; no values printed')
    names = subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0')
    errors, count = [], 0
    for name in filter(None, names):
        file = ROOT / name
        if not file.exists() and not file.is_symlink():
            # A staged deletion is absent locally; a later staged-file check
            # and clean-tree verification cover the publication boundary.
            continue
        raw = str(file.readlink()).encode() if file.is_symlink() else file.read_bytes()
        count += 1
        errors.extend(name + ': ' + message for message in check_candidate(name, raw, needles))

    config = plistlib.loads((ROOT / 'EFI/OC/config.plist').read_bytes())
    props = config['DeviceProperties']['Add'][GPU_PATH]
    mapping = props.get('CFG_LINK_BUILT_IN_MAP')
    if isinstance(mapping, bytes):
        mapping = int.from_bytes(mapping, 'little')
    if mapping != 1 or 'CFG_LINK_FIXED_MAP' in props:
        errors.append('config: expected Built-In mapping without Fixed mapping')
    flags = set(config['NVRAM']['Add']['7C436110-AB2A-4BBB-A880-FE41995C9F82']['boot-args'].split())
    if not {'-a51mbattime', 'applbkl=0'} <= flags:
        errors.append('config: missing release battery/backlight flag')
    if flags & FORBIDDEN_FLAGS:
        errors.append('config: diagnostic or obsolete test flags enabled')

    manifest = json.loads((ROOT / 'release-manifest.json').read_text())
    for name, expected in manifest['files_sha256'].items():
        file = ROOT / name
        if not file.is_file() or hashlib.sha256(file.read_bytes()).hexdigest() != expected:
            errors.append(name + ': release checksum mismatch')
    for name, expected in [('A51mR2Backlight', '1.2.7'), ('SMCBatteryManager', '1.3.8')]:
        info = plistlib.loads((ROOT / f'EFI/OC/Kexts/{name}.kext/Contents/Info.plist').read_bytes())
        if info.get('CFBundleVersion') != expected:
            errors.append(name + ': unexpected release version')
    enabled = [item['BundlePath'] for item in config['Kernel']['Add'] if item.get('Enabled')]
    for name in ['A51mR2Backlight.kext', 'SMCBatteryManager.kext']:
        if enabled.count(name) != 1:
            errors.append(name + ': expected exactly one enabled entry')
    if enabled.index('Lilu.kext') > enabled.index('A51mR2Backlight.kext'):
        errors.append('config: Lilu must precede backlight plugin')
    if enabled.index('VirtualSMC.kext') > enabled.index('SMCBatteryManager.kext'):
        errors.append('config: VirtualSMC must precede battery plugin')
    if errors:
        print('\n'.join('FAIL ' + message for message in errors))
        return 1
    print(f'PASS: {count} tracked files; public identities, release profile, dependencies and checksums')
    return 0


if __name__ == '__main__':
    sys.exit(main())
