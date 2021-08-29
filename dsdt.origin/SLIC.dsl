/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./SLIC.aml, Mon Aug 23 21:16:16 2021
 *
 * ACPI Data Table [SLIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "SLIC"    [Software Licensing Description Table]
[004h 0004   4]                 Table Length : 00000176
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 85
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "ALIENWRE"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 00010013

[024h 0036 338] Software Licensing Structure : \
    00 00 00 00 9C 00 00 00 06 02 00 00 00 24 00 00 \
    52 53 41 31 00 04 00 00 01 00 01 00 1B 24 73 DF \
    1D 89 5B DE 2F C3 93 90 98 45 7E 58 CB A0 0B 43 \
    FA F4 A2 9A 38 D9 27 6C 22 9A 77 7B 01 6C 84 32 \
    40 1D F0 34 B3 F9 B6 83 BB BB 91 06 11 FE BA 69 \
    B2 4F E5 57 BB F8 D6 89 94 08 63 67 4E 34 D0 26 \
    EF C2 D2 A8 D4 E4 C5 6F 7B 26 14 D6 90 8D C4 A5 \
    51 72 69 11 47 05 94 BB 58 43 E7 F2 18 9A E7 84 \
    0E 99 14 A4 96 1C 3A 8A 73 6A 03 14 39 C4 28 D5 \
    FC B9 DD 86 A1 96 67 AB BC DA 7D E1 01 00 00 00 \
    B6 00 00 00 00 00 02 00 41 4C 57 41 52 45 41 4C \
    49 45 4E 57 52 45 57 49 4E 44 4F 57 53 20 01 00 \
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
    00 00 55 35 96 8D 4E 4F C5 41 74 AA D0 FD 8E AD \
    49 73 1E F9 DE 26 A3 29 1E 7E 47 39 70 E4 A2 16 \
    B2 05 8D 4F 89 0C 59 52 5D DD C2 68 E9 F3 E8 1A \
    B5 3A 9D 42 59 C3 81 91 76 60 A8 D2 2B 34 FA 6C \
    32 75 BC 09 D0 F2 21 B4 C4 62 BD 70 8D F7 DF 7B \
    D1 C9 77 BA 31 69 92 BB 87 8C 95 82 B0 78 5B E7 \
    B7 1B FF C3 D5 63 B1 59 97 8B A9 5A EF 13 CE 90 \
    A5 70 36 AF 10 6E ED C4 34 C8 7E DB 87 0E 7A D5 \
    7F 62 

Raw Table Data: Length 374 (0x176)

    0000: 53 4C 49 43 76 01 00 00 01 85 41 4C 57 41 52 45  // SLICv.....ALWARE
    0010: 41 4C 49 45 4E 57 52 45 09 20 07 01 41 4D 49 20  // ALIENWRE. ..AMI 
    0020: 13 00 01 00 00 00 00 00 9C 00 00 00 06 02 00 00  // ................
    0030: 00 24 00 00 52 53 41 31 00 04 00 00 01 00 01 00  // .$..RSA1........
    0040: 1B 24 73 DF 1D 89 5B DE 2F C3 93 90 98 45 7E 58  // .$s...[./....E~X
    0050: CB A0 0B 43 FA F4 A2 9A 38 D9 27 6C 22 9A 77 7B  // ...C....8.'l".w{
    0060: 01 6C 84 32 40 1D F0 34 B3 F9 B6 83 BB BB 91 06  // .l.2@..4........
    0070: 11 FE BA 69 B2 4F E5 57 BB F8 D6 89 94 08 63 67  // ...i.O.W......cg
    0080: 4E 34 D0 26 EF C2 D2 A8 D4 E4 C5 6F 7B 26 14 D6  // N4.&.......o{&..
    0090: 90 8D C4 A5 51 72 69 11 47 05 94 BB 58 43 E7 F2  // ....Qri.G...XC..
    00A0: 18 9A E7 84 0E 99 14 A4 96 1C 3A 8A 73 6A 03 14  // ..........:.sj..
    00B0: 39 C4 28 D5 FC B9 DD 86 A1 96 67 AB BC DA 7D E1  // 9.(.......g...}.
    00C0: 01 00 00 00 B6 00 00 00 00 00 02 00 41 4C 57 41  // ............ALWA
    00D0: 52 45 41 4C 49 45 4E 57 52 45 57 49 4E 44 4F 57  // REALIENWREWINDOW
    00E0: 53 20 01 00 02 00 00 00 00 00 00 00 00 00 00 00  // S ..............
    00F0: 00 00 00 00 00 00 55 35 96 8D 4E 4F C5 41 74 AA  // ......U5..NO.At.
    0100: D0 FD 8E AD 49 73 1E F9 DE 26 A3 29 1E 7E 47 39  // ....Is...&.).~G9
    0110: 70 E4 A2 16 B2 05 8D 4F 89 0C 59 52 5D DD C2 68  // p......O..YR]..h
    0120: E9 F3 E8 1A B5 3A 9D 42 59 C3 81 91 76 60 A8 D2  // .....:.BY...v`..
    0130: 2B 34 FA 6C 32 75 BC 09 D0 F2 21 B4 C4 62 BD 70  // +4.l2u....!..b.p
    0140: 8D F7 DF 7B D1 C9 77 BA 31 69 92 BB 87 8C 95 82  // ...{..w.1i......
    0150: B0 78 5B E7 B7 1B FF C3 D5 63 B1 59 97 8B A9 5A  // .x[......c.Y...Z
    0160: EF 13 CE 90 A5 70 36 AF 10 6E ED C4 34 C8 7E DB  // .....p6..n..4.~.
    0170: 87 0E 7A D5 7F 62                                // ..z..b
