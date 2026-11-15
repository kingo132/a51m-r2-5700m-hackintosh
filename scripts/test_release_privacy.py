"""Negative controls for publishing identities and enabling diagnostic profiles."""

import base64
import plistlib
import unittest

from check_release import check_candidate, encoded_needles, identity_findings


class PrivacyTests(unittest.TestCase):
    def test_all_platform_sections(self):
        for section in ['Generic', 'DataHub', 'SMBIOS', 'PlatformNVRAM']:
            with self.subTest(section=section):
                obj = {'PlatformInfo': {section: {'SystemSerialNumber': 'EXAMPLE' + '12345'}}}
                self.assertEqual(len(identity_findings(obj)), 1)

    def test_public_placeholders(self):
        self.assertEqual(identity_findings({'MLB': '', 'ROM': bytes(6),
                                            'SystemUUID': '00000000-0000-0000-0000-000000000000'}), [])

    def test_nonzero_rom_and_mlb(self):
        self.assertEqual(len(identity_findings({'ROM': bytes(range(6)), 'MLB': 'EXAMPLE' + 'BOARD'})), 2)

    def test_software_uuid_not_hardware_identity(self):
        self.assertEqual(identity_findings({'image_uuid': 'a' * 32}), [])

    def test_private_text_encodings(self):
        value = 'PRIVATE' + 'EXAMPLE'
        needles = encoded_needles([{'text': value}])
        for raw in [value.encode(), value.encode('utf-16-le'),
                    value.encode('utf-16-be'), base64.b64encode(value.encode())]:
            with self.subTest(encoding=len(raw)):
                self.assertTrue(check_candidate('notes.md', raw, needles))

    def test_wrapped_plist_data(self):
        value = bytes(range(10, 26))
        needles = encoded_needles([{'hex': value.hex()}])
        for fmt in [plistlib.FMT_XML, plistlib.FMT_BINARY]:
            self.assertTrue(check_candidate('data.plist', plistlib.dumps({'payload': value}, fmt=fmt), needles))

    def test_dump_and_license_containers(self):
        for name in ['capture.zip', 'capture.ioreg', 'private/data.txt',
                     'EFI/Backups/data', 'dsdt.origin/MSDM.aml']:
            with self.subTest(path=name):
                self.assertTrue(check_candidate(name, b''))

    def test_regular_source(self):
        self.assertEqual(check_candidate('source.cpp', b'int count = 0;'), [])


if __name__ == '__main__':
    unittest.main()
