/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./FPDT.aml, Mon Aug 23 21:16:16 2021
 *
 * ACPI Data Table [FPDT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "FPDT"    [Firmware Performance Data Table]
[004h 0004   4]                 Table Length : 00000044
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 19
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "CML"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 01000013


[024h 0036   2]                Subtable Type : 0000
[026h 0038   1]                       Length : 10
[027h 0039   1]                     Revision : 01
[028h 0040   4]                     Reserved : 00000000
[02Ch 0044   8]     FPDT Boot Record Address : 000000007C238000

[034h 0052   2]                Subtable Type : 0001
[036h 0054   1]                       Length : 10
[037h 0055   1]                     Revision : 01
[038h 0056   4]                     Reserved : 00000000
[03Ch 0060   8]          S3PT Record Address : 0000000081BD2000

Raw Table Data: Length 68 (0x44)

    0000: 46 50 44 54 44 00 00 00 01 19 41 4C 57 41 52 45  // FPDTD.....ALWARE
    0010: 43 4D 4C 00 00 00 00 00 09 20 07 01 41 4D 49 20  // CML...... ..AMI 
    0020: 13 00 00 01 00 00 10 01 00 00 00 00 00 80 23 7C  // ..............#|
    0030: 00 00 00 00 01 00 10 01 00 00 00 00 00 20 BD 81  // ............. ..
    0040: 00 00 00 00                                      // ....
