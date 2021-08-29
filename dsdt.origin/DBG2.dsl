/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./DBG2.aml, Mon Aug 23 21:16:15 2021
 *
 * ACPI Data Table [DBG2]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "DBG2"    [Debug Port table type 2]
[004h 0004   4]                 Table Length : 00000054
[008h 0008   1]                     Revision : 00
[009h 0009   1]                     Checksum : E9
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "ALIENWRE"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 01000013

[024h 0036   4]                  Info Offset : 0000002C
[028h 0040   4]                   Info Count : 00000001

[02Ch 0044   1]                     Revision : 00
[02Dh 0045   2]                       Length : 0028
[02Fh 0047   1]               Register Count : 01
[030h 0048   2]              Namepath Length : 0002
[032h 0050   2]              Namepath Offset : 0026
[034h 0052   2]              OEM Data Length : 0000 [Optional field not present]
[036h 0054   2]              OEM Data Offset : 0000 [Optional field not present]
[038h 0056   2]                    Port Type : 8000
[03Ah 0058   2]                 Port Subtype : 0001
[03Ch 0060   2]                     Reserved : 0000
[03Eh 0062   2]          Base Address Offset : 0016
[040h 0064   2]          Address Size Offset : 0022

[042h 0066  12]        Base Address Register : [Generic Address Structure]
[042h 0066   1]                     Space ID : 01 [SystemIO]
[043h 0067   1]                    Bit Width : 08
[044h 0068   1]                   Bit Offset : 00
[045h 0069   1]         Encoded Access Width : 00 [Undefined/Legacy]
[046h 0070   8]                      Address : 00000000000003F8

[04Eh 0078   4]                 Address Size : 0000000C

[052h 0082   2]                     Namepath : "."

Raw Table Data: Length 84 (0x54)

    0000: 44 42 47 32 54 00 00 00 00 E9 41 4C 57 41 52 45  // DBG2T.....ALWARE
    0010: 41 4C 49 45 4E 57 52 45 09 20 07 01 41 4D 49 20  // ALIENWRE. ..AMI 
    0020: 13 00 00 01 2C 00 00 00 01 00 00 00 00 28 00 01  // ....,........(..
    0030: 02 00 26 00 00 00 00 00 00 80 01 00 00 00 16 00  // ..&.............
    0040: 22 00 01 08 00 00 F8 03 00 00 00 00 00 00 0C 00  // "...............
    0050: 00 00 2E 00                                      // ....
