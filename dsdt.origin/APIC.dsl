/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ./APIC.aml, Mon Aug 23 21:16:15 2021
 *
 * ACPI Data Table [APIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
[004h 0004   4]                 Table Length : 00000164
[008h 0008   1]                     Revision : 04
[009h 0009   1]                     Checksum : F0
[00Ah 0010   6]                       Oem ID : "ALWARE"
[010h 0016   8]                 Oem Table ID : "ALIENWRE"
[018h 0024   4]                 Oem Revision : 01072009
[01Ch 0028   4]              Asl Compiler ID : "AMI "
[020h 0032   4]        Asl Compiler Revision : 00010013

[024h 0036   4]           Local Apic Address : FEE00000
[028h 0040   4]        Flags (decoded below) : 00000001
                         PC-AT Compatibility : 1

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Dh 0045   1]                       Length : 08
[02Eh 0046   1]                 Processor ID : 01
[02Fh 0047   1]                Local Apic ID : 00
[030h 0048   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[034h 0052   1]                Subtable Type : 04 [Local APIC NMI]
[035h 0053   1]                       Length : 06
[036h 0054   1]                 Processor ID : 01
[037h 0055   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[039h 0057   1]         Interrupt Input LINT : 01

[03Ah 0058   1]                Subtable Type : 00 [Processor Local APIC]
[03Bh 0059   1]                       Length : 08
[03Ch 0060   1]                 Processor ID : 02
[03Dh 0061   1]                Local Apic ID : 02
[03Eh 0062   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[042h 0066   1]                Subtable Type : 04 [Local APIC NMI]
[043h 0067   1]                       Length : 06
[044h 0068   1]                 Processor ID : 02
[045h 0069   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[047h 0071   1]         Interrupt Input LINT : 01

[048h 0072   1]                Subtable Type : 00 [Processor Local APIC]
[049h 0073   1]                       Length : 08
[04Ah 0074   1]                 Processor ID : 03
[04Bh 0075   1]                Local Apic ID : 04
[04Ch 0076   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[050h 0080   1]                Subtable Type : 04 [Local APIC NMI]
[051h 0081   1]                       Length : 06
[052h 0082   1]                 Processor ID : 03
[053h 0083   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[055h 0085   1]         Interrupt Input LINT : 01

[056h 0086   1]                Subtable Type : 00 [Processor Local APIC]
[057h 0087   1]                       Length : 08
[058h 0088   1]                 Processor ID : 04
[059h 0089   1]                Local Apic ID : 06
[05Ah 0090   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[05Eh 0094   1]                Subtable Type : 04 [Local APIC NMI]
[05Fh 0095   1]                       Length : 06
[060h 0096   1]                 Processor ID : 04
[061h 0097   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[063h 0099   1]         Interrupt Input LINT : 01

[064h 0100   1]                Subtable Type : 00 [Processor Local APIC]
[065h 0101   1]                       Length : 08
[066h 0102   1]                 Processor ID : 05
[067h 0103   1]                Local Apic ID : 08
[068h 0104   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[06Ch 0108   1]                Subtable Type : 04 [Local APIC NMI]
[06Dh 0109   1]                       Length : 06
[06Eh 0110   1]                 Processor ID : 05
[06Fh 0111   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[071h 0113   1]         Interrupt Input LINT : 01

[072h 0114   1]                Subtable Type : 00 [Processor Local APIC]
[073h 0115   1]                       Length : 08
[074h 0116   1]                 Processor ID : 06
[075h 0117   1]                Local Apic ID : 0A
[076h 0118   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[07Ah 0122   1]                Subtable Type : 04 [Local APIC NMI]
[07Bh 0123   1]                       Length : 06
[07Ch 0124   1]                 Processor ID : 06
[07Dh 0125   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[07Fh 0127   1]         Interrupt Input LINT : 01

[080h 0128   1]                Subtable Type : 00 [Processor Local APIC]
[081h 0129   1]                       Length : 08
[082h 0130   1]                 Processor ID : 07
[083h 0131   1]                Local Apic ID : 0C
[084h 0132   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[088h 0136   1]                Subtable Type : 04 [Local APIC NMI]
[089h 0137   1]                       Length : 06
[08Ah 0138   1]                 Processor ID : 07
[08Bh 0139   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[08Dh 0141   1]         Interrupt Input LINT : 01

[08Eh 0142   1]                Subtable Type : 00 [Processor Local APIC]
[08Fh 0143   1]                       Length : 08
[090h 0144   1]                 Processor ID : 08
[091h 0145   1]                Local Apic ID : 0E
[092h 0146   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[096h 0150   1]                Subtable Type : 04 [Local APIC NMI]
[097h 0151   1]                       Length : 06
[098h 0152   1]                 Processor ID : 08
[099h 0153   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[09Bh 0155   1]         Interrupt Input LINT : 01

[09Ch 0156   1]                Subtable Type : 00 [Processor Local APIC]
[09Dh 0157   1]                       Length : 08
[09Eh 0158   1]                 Processor ID : 09
[09Fh 0159   1]                Local Apic ID : 10
[0A0h 0160   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0A4h 0164   1]                Subtable Type : 04 [Local APIC NMI]
[0A5h 0165   1]                       Length : 06
[0A6h 0166   1]                 Processor ID : 09
[0A7h 0167   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0A9h 0169   1]         Interrupt Input LINT : 01

[0AAh 0170   1]                Subtable Type : 00 [Processor Local APIC]
[0ABh 0171   1]                       Length : 08
[0ACh 0172   1]                 Processor ID : 0A
[0ADh 0173   1]                Local Apic ID : 12
[0AEh 0174   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0B2h 0178   1]                Subtable Type : 04 [Local APIC NMI]
[0B3h 0179   1]                       Length : 06
[0B4h 0180   1]                 Processor ID : 0A
[0B5h 0181   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0B7h 0183   1]         Interrupt Input LINT : 01

[0B8h 0184   1]                Subtable Type : 00 [Processor Local APIC]
[0B9h 0185   1]                       Length : 08
[0BAh 0186   1]                 Processor ID : 0B
[0BBh 0187   1]                Local Apic ID : 01
[0BCh 0188   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0C0h 0192   1]                Subtable Type : 04 [Local APIC NMI]
[0C1h 0193   1]                       Length : 06
[0C2h 0194   1]                 Processor ID : 0B
[0C3h 0195   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0C5h 0197   1]         Interrupt Input LINT : 01

[0C6h 0198   1]                Subtable Type : 00 [Processor Local APIC]
[0C7h 0199   1]                       Length : 08
[0C8h 0200   1]                 Processor ID : 0C
[0C9h 0201   1]                Local Apic ID : 03
[0CAh 0202   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0CEh 0206   1]                Subtable Type : 04 [Local APIC NMI]
[0CFh 0207   1]                       Length : 06
[0D0h 0208   1]                 Processor ID : 0C
[0D1h 0209   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0D3h 0211   1]         Interrupt Input LINT : 01

[0D4h 0212   1]                Subtable Type : 00 [Processor Local APIC]
[0D5h 0213   1]                       Length : 08
[0D6h 0214   1]                 Processor ID : 0D
[0D7h 0215   1]                Local Apic ID : 05
[0D8h 0216   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0DCh 0220   1]                Subtable Type : 04 [Local APIC NMI]
[0DDh 0221   1]                       Length : 06
[0DEh 0222   1]                 Processor ID : 0D
[0DFh 0223   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0E1h 0225   1]         Interrupt Input LINT : 01

[0E2h 0226   1]                Subtable Type : 00 [Processor Local APIC]
[0E3h 0227   1]                       Length : 08
[0E4h 0228   1]                 Processor ID : 0E
[0E5h 0229   1]                Local Apic ID : 07
[0E6h 0230   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0EAh 0234   1]                Subtable Type : 04 [Local APIC NMI]
[0EBh 0235   1]                       Length : 06
[0ECh 0236   1]                 Processor ID : 0E
[0EDh 0237   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0EFh 0239   1]         Interrupt Input LINT : 01

[0F0h 0240   1]                Subtable Type : 00 [Processor Local APIC]
[0F1h 0241   1]                       Length : 08
[0F2h 0242   1]                 Processor ID : 0F
[0F3h 0243   1]                Local Apic ID : 09
[0F4h 0244   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[0F8h 0248   1]                Subtable Type : 04 [Local APIC NMI]
[0F9h 0249   1]                       Length : 06
[0FAh 0250   1]                 Processor ID : 0F
[0FBh 0251   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[0FDh 0253   1]         Interrupt Input LINT : 01

[0FEh 0254   1]                Subtable Type : 00 [Processor Local APIC]
[0FFh 0255   1]                       Length : 08
[100h 0256   1]                 Processor ID : 10
[101h 0257   1]                Local Apic ID : 0B
[102h 0258   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[106h 0262   1]                Subtable Type : 04 [Local APIC NMI]
[107h 0263   1]                       Length : 06
[108h 0264   1]                 Processor ID : 10
[109h 0265   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[10Bh 0267   1]         Interrupt Input LINT : 01

[10Ch 0268   1]                Subtable Type : 00 [Processor Local APIC]
[10Dh 0269   1]                       Length : 08
[10Eh 0270   1]                 Processor ID : 11
[10Fh 0271   1]                Local Apic ID : 0D
[110h 0272   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[114h 0276   1]                Subtable Type : 04 [Local APIC NMI]
[115h 0277   1]                       Length : 06
[116h 0278   1]                 Processor ID : 11
[117h 0279   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[119h 0281   1]         Interrupt Input LINT : 01

[11Ah 0282   1]                Subtable Type : 00 [Processor Local APIC]
[11Bh 0283   1]                       Length : 08
[11Ch 0284   1]                 Processor ID : 12
[11Dh 0285   1]                Local Apic ID : 0F
[11Eh 0286   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[122h 0290   1]                Subtable Type : 04 [Local APIC NMI]
[123h 0291   1]                       Length : 06
[124h 0292   1]                 Processor ID : 12
[125h 0293   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[127h 0295   1]         Interrupt Input LINT : 01

[128h 0296   1]                Subtable Type : 00 [Processor Local APIC]
[129h 0297   1]                       Length : 08
[12Ah 0298   1]                 Processor ID : 13
[12Bh 0299   1]                Local Apic ID : 11
[12Ch 0300   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[130h 0304   1]                Subtable Type : 04 [Local APIC NMI]
[131h 0305   1]                       Length : 06
[132h 0306   1]                 Processor ID : 13
[133h 0307   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[135h 0309   1]         Interrupt Input LINT : 01

[136h 0310   1]                Subtable Type : 00 [Processor Local APIC]
[137h 0311   1]                       Length : 08
[138h 0312   1]                 Processor ID : 14
[139h 0313   1]                Local Apic ID : 13
[13Ah 0314   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[13Eh 0318   1]                Subtable Type : 04 [Local APIC NMI]
[13Fh 0319   1]                       Length : 06
[140h 0320   1]                 Processor ID : 14
[141h 0321   2]        Flags (decoded below) : 0005
                                    Polarity : 1
                                Trigger Mode : 1
[143h 0323   1]         Interrupt Input LINT : 01

[144h 0324   1]                Subtable Type : 01 [I/O APIC]
[145h 0325   1]                       Length : 0C
[146h 0326   1]                  I/O Apic ID : 02
[147h 0327   1]                     Reserved : 00
[148h 0328   4]                      Address : FEC00000
[14Ch 0332   4]                    Interrupt : 00000000

[150h 0336   1]                Subtable Type : 02 [Interrupt Source Override]
[151h 0337   1]                       Length : 0A
[152h 0338   1]                          Bus : 00
[153h 0339   1]                       Source : 00
[154h 0340   4]                    Interrupt : 00000002
[158h 0344   2]        Flags (decoded below) : 0000
                                    Polarity : 0
                                Trigger Mode : 0

[15Ah 0346   1]                Subtable Type : 02 [Interrupt Source Override]
[15Bh 0347   1]                       Length : 0A
[15Ch 0348   1]                          Bus : 00
[15Dh 0349   1]                       Source : 09
[15Eh 0350   4]                    Interrupt : 00000009
[162h 0354   2]        Flags (decoded below) : 000D
                                    Polarity : 1
                                Trigger Mode : 3

Raw Table Data: Length 356 (0x164)

    0000: 41 50 49 43 64 01 00 00 04 F0 41 4C 57 41 52 45  // APICd.....ALWARE
    0010: 41 4C 49 45 4E 57 52 45 09 20 07 01 41 4D 49 20  // ALIENWRE. ..AMI 
    0020: 13 00 01 00 00 00 E0 FE 01 00 00 00 00 08 01 00  // ................
    0030: 01 00 00 00 04 06 01 05 00 01 00 08 02 02 01 00  // ................
    0040: 00 00 04 06 02 05 00 01 00 08 03 04 01 00 00 00  // ................
    0050: 04 06 03 05 00 01 00 08 04 06 01 00 00 00 04 06  // ................
    0060: 04 05 00 01 00 08 05 08 01 00 00 00 04 06 05 05  // ................
    0070: 00 01 00 08 06 0A 01 00 00 00 04 06 06 05 00 01  // ................
    0080: 00 08 07 0C 01 00 00 00 04 06 07 05 00 01 00 08  // ................
    0090: 08 0E 01 00 00 00 04 06 08 05 00 01 00 08 09 10  // ................
    00A0: 01 00 00 00 04 06 09 05 00 01 00 08 0A 12 01 00  // ................
    00B0: 00 00 04 06 0A 05 00 01 00 08 0B 01 01 00 00 00  // ................
    00C0: 04 06 0B 05 00 01 00 08 0C 03 01 00 00 00 04 06  // ................
    00D0: 0C 05 00 01 00 08 0D 05 01 00 00 00 04 06 0D 05  // ................
    00E0: 00 01 00 08 0E 07 01 00 00 00 04 06 0E 05 00 01  // ................
    00F0: 00 08 0F 09 01 00 00 00 04 06 0F 05 00 01 00 08  // ................
    0100: 10 0B 01 00 00 00 04 06 10 05 00 01 00 08 11 0D  // ................
    0110: 01 00 00 00 04 06 11 05 00 01 00 08 12 0F 01 00  // ................
    0120: 00 00 04 06 12 05 00 01 00 08 13 11 01 00 00 00  // ................
    0130: 04 06 13 05 00 01 00 08 14 13 01 00 00 00 04 06  // ................
    0140: 14 05 00 01 01 0C 02 00 00 00 C0 FE 00 00 00 00  // ................
    0150: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 09 09 00  // ................
    0160: 00 00 0D 00                                      // ....
