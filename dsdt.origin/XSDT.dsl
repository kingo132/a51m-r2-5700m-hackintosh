/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./XSDT.aml, Mon Aug 23 21:16:16 2021
 *
 * ACPI Data Table [XSDT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "XSDT"    [Extended System Description Table]
[004h 0004   4]                 Table Length : 0000011C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : CC
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "ALIENWRE"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 01000013

[024h 0036   8]       ACPI Table Address   0 : 0000000081CF9000
[02Ch 0044   8]       ACPI Table Address   1 : 0000000081D02000
[034h 0052   8]       ACPI Table Address   2 : 0000000081CFF000
[03Ch 0060   8]       ACPI Table Address   3 : 0000000081CFA000
[044h 0068   8]       ACPI Table Address   4 : 0000000081CAF000
[04Ch 0076   8]       ACPI Table Address   5 : 0000000081CAE000
[054h 0084   8]       ACPI Table Address   6 : 0000000081CAD000
[05Ch 0092   8]       ACPI Table Address   7 : 0000000081CAC000
[064h 0100   8]       ACPI Table Address   8 : 0000000081CAB000
[06Ch 0108   8]       ACPI Table Address   9 : 0000000081CA7000
[074h 0116   8]       ACPI Table Address  10 : 0000000081CA4000
[07Ch 0124   8]       ACPI Table Address  11 : 0000000081CA3000
[084h 0132   8]       ACPI Table Address  12 : 0000000081C9F000
[08Ch 0140   8]       ACPI Table Address  13 : 0000000081C9B000
[094h 0148   8]       ACPI Table Address  14 : 0000000081C99000
[09Ch 0156   8]       ACPI Table Address  15 : 0000000081C98000
[0A4h 0164   8]       ACPI Table Address  16 : 0000000081C97000
[0ACh 0172   8]       ACPI Table Address  17 : 0000000081C93000
[0B4h 0180   8]       ACPI Table Address  18 : 0000000081C90000
[0BCh 0188   8]       ACPI Table Address  19 : 0000000081C8F000
[0C4h 0196   8]       ACPI Table Address  20 : 0000000081C8E000
[0CCh 0204   8]       ACPI Table Address  21 : 0000000081C8D000
[0D4h 0212   8]       ACPI Table Address  22 : 0000000081C7E000
[0DCh 0220   8]       ACPI Table Address  23 : 0000000081C7C000
[0E4h 0228   8]       ACPI Table Address  24 : 0000000081C7B000
[0ECh 0236   8]       ACPI Table Address  25 : 0000000081C7D000
[0F4h 0244   8]       ACPI Table Address  26 : 0000000081C79000
[0FCh 0252   8]       ACPI Table Address  27 : 0000000081C78000
[104h 0260   8]       ACPI Table Address  28 : 0000000081C96000
[10Ch 0268   8]       ACPI Table Address  29 : 0000000081C77000
[114h 0276   8]       ACPI Table Address  30 : 0000000081C76000

Raw Table Data: Length 284 (0x11C)

    0000: 58 53 44 54 1C 01 00 00 01 CC 41 4C 57 41 52 45  // XSDT......ALWARE
    0010: 41 4C 49 45 4E 57 52 45 09 20 07 01 41 4D 49 20  // ALIENWRE. ..AMI 
    0020: 13 00 00 01 00 90 CF 81 00 00 00 00 00 20 D0 81  // ............. ..
    0030: 00 00 00 00 00 F0 CF 81 00 00 00 00 00 A0 CF 81  // ................
    0040: 00 00 00 00 00 F0 CA 81 00 00 00 00 00 E0 CA 81  // ................
    0050: 00 00 00 00 00 D0 CA 81 00 00 00 00 00 C0 CA 81  // ................
    0060: 00 00 00 00 00 B0 CA 81 00 00 00 00 00 70 CA 81  // .............p..
    0070: 00 00 00 00 00 40 CA 81 00 00 00 00 00 30 CA 81  // .....@.......0..
    0080: 00 00 00 00 00 F0 C9 81 00 00 00 00 00 B0 C9 81  // ................
    0090: 00 00 00 00 00 90 C9 81 00 00 00 00 00 80 C9 81  // ................
    00A0: 00 00 00 00 00 70 C9 81 00 00 00 00 00 30 C9 81  // .....p.......0..
    00B0: 00 00 00 00 00 00 C9 81 00 00 00 00 00 F0 C8 81  // ................
    00C0: 00 00 00 00 00 E0 C8 81 00 00 00 00 00 D0 C8 81  // ................
    00D0: 00 00 00 00 00 E0 C7 81 00 00 00 00 00 C0 C7 81  // ................
    00E0: 00 00 00 00 00 B0 C7 81 00 00 00 00 00 D0 C7 81  // ................
    00F0: 00 00 00 00 00 90 C7 81 00 00 00 00 00 80 C7 81  // ................
    0100: 00 00 00 00 00 60 C9 81 00 00 00 00 00 70 C7 81  // .....`.......p..
    0110: 00 00 00 00 00 60 C7 81 00 00 00 00              // .....`......
