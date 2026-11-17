#!/usr/bin/env python3
"""Execute the production wake AML in a hardware-free ACPICA namespace."""
import pathlib
import re
import shutil
import subprocess
import tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]
FIXTURE = r'''DefinitionBlock ("", "DSDT", 2, "A51M", "TESTONLY", 1)
{
    Name (WKCT, Zero)
    Method (_WAK, 1, Serialized) {
        Increment (WKCT)
        Return (Package (2) {Zero, Zero})
    }
    Scope (_SB) {
        Device (PCI0) {
            Name (_HID, EisaId ("PNP0A08"))
            Device (LPCB) {
                Name (_ADR, 0x001F0000)
                Device (LID0) {
                    Name (_HID, EisaId ("PNP0C0D"))
                    Method (_LID, 0) {Return (One)}
                }
            }
        }
    }
}'''


def main():
    iasl, executor = shutil.which('iasl'), shutil.which('acpiexec')
    if not iasl or not executor:
        raise SystemExit('iasl and acpiexec are required; no live hardware is used.')
    with tempfile.TemporaryDirectory(prefix='a51m-acpi-test-') as tmp:
        tmp = pathlib.Path(tmp)
        for name, text in [('fixture', FIXTURE), ('wake',
                (ROOT / 'sources/ACPI/SSDT-AOACWAKE.dsl').read_text())]:
            source = tmp / (name + '.dsl')
            source.write_text(text)
            subprocess.run([iasl, '-we', str(source)], check=True, capture_output=True)
        binary = (tmp / 'wake.aml').read_bytes()
        assert b'RMDT' not in binary and b'_WAK' not in binary
        assert sum(binary) % 256 == 0
        on, off = r'execute \_SB.PCI0.LPCB._PS0', r'execute \_SB.PCI0.LPCB._PS3'
        cases = [
            ('cold_boot', True, [on, on], 0, 0),
            ('device_resume', True, [off, on], 1, 0),
            ('repeated_D0', True, [off, on, on], 1, 0),
            ('three_cycles', True, [off, on] * 3, 3, 0),
            ('OSPM_owns_system_wake', True, [off, r'execute \_WAK 3', on], 1, 1),
            ('other_OS', False, [on], 0, 0),
        ]
        for name, darwin, commands, notifications, wakes in cases:
            batch = ['osi ' + ('install' if darwin else 'remove') + ' Darwin',
                     'load ' + str(tmp / 'wake.aml'), *commands, r'execute \WKCT']
            result = subprocess.run([executor, '-df', '-b', ';'.join(batch),
                                     str(tmp / 'fixture.aml')], capture_output=True,
                                    text=True, timeout=15)
            log = result.stdout + result.stderr
            count = len(re.findall(r'Received a Device Notify on \[LID0\].*Value 0x80', log))
            assert count == notifications, (name, count, log)
            value = log.split(r'Evaluating \WKCT')[-1]
            actual = re.search(r'\[Integer\] = ([0-9A-Fa-f]+)', value)
            assert actual and int(actual[1], 16) == wakes, (name, log)
            assert ('failed with status AE_NOT_FOUND' not in log) == darwin, (name, log)
            assert 'Aborting method' not in log, (name, log)
            print('PASS', name, 'lid_notifications=' + str(count), 'system_wakes=' + str(wakes))
    print('PASS: AML checksum, no RMDT dependency, no synthetic system _WAK; offline only')


if __name__ == '__main__':
    main()
