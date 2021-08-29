/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./DBGP.aml, Mon Aug 23 21:16:15 2021
 *
 * ACPI Data Table [DBGP]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "DBGP"    [Debug Port table]
[004h 0004   4]                 Table Length : 00000034
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 5B
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "ALIENWRE"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 01000013

[024h 0036   1]               Interface Type : 00
[025h 0037   3]                     Reserved : 000000

[028h 0040  12]          Debug Port Register : [Generic Address Structure]
[028h 0040   1]                     Space ID : 01 [SystemIO]
[029h 0041   1]                    Bit Width : 08
[02Ah 0042   1]                   Bit Offset : 00
[02Bh 0043   1]         Encoded Access Width : 00 [Undefined/Legacy]
[02Ch 0044   8]                      Address : 00000000000003F8


Raw Table Data: Length 52 (0x34)

    0000: 44 42 47 50 34 00 00 00 01 5B 41 4C 57 41 52 45  // DBGP4....[ALWARE
    0010: 41 4C 49 45 4E 57 52 45 09 20 07 01 41 4D 49 20  // ALIENWRE. ..AMI 
    0020: 13 00 00 01 00 00 00 00 01 08 00 00 F8 03 00 00  // ................
    0030: 00 00 00 00                                      // ....
