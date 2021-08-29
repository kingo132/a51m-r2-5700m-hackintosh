/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-1-DptfTabl.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00004074 (16500)
 *     Revision         0x02
 *     Checksum         0x52
 *     OEM ID           "INTEL "
 *     OEM Table ID     "DptfTabl"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL ", "DptfTabl", 0x00001000)
{
    External (_SB_.AAC0, FieldUnitObj)
    External (_SB_.ACRT, FieldUnitObj)
    External (_SB_.APSV, FieldUnitObj)
    External (_SB_.CBMI, FieldUnitObj)
    External (_SB_.CFGD, FieldUnitObj)
    External (_SB_.CLVL, FieldUnitObj)
    External (_SB_.CPPC, FieldUnitObj)
    External (_SB_.CTC0, FieldUnitObj)
    External (_SB_.CTC1, FieldUnitObj)
    External (_SB_.CTC2, FieldUnitObj)
    External (_SB_.OSCP, IntObj)
    External (_SB_.PAGD, DeviceObj)
    External (_SB_.PAGD._PUR, PkgObj)
    External (_SB_.PAGD._STA, MethodObj)    // 0 Arguments
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.B0D4, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.EST1, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.EST2, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.EST3, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.MEMT, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.SKTC, IntObj)
    External (_SB_.PCI0.LPCB.EC0_.TSSR, IntObj)
    External (_SB_.PCI0.LPCB.ECOK, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.H_EC.UVTH, FieldUnitObj)
    External (_SB_.PCI0.MHBR, FieldUnitObj)
    External (_SB_.PL10, FieldUnitObj)
    External (_SB_.PL11, FieldUnitObj)
    External (_SB_.PL12, FieldUnitObj)
    External (_SB_.PL20, FieldUnitObj)
    External (_SB_.PL21, FieldUnitObj)
    External (_SB_.PL22, FieldUnitObj)
    External (_SB_.PLW0, FieldUnitObj)
    External (_SB_.PLW1, FieldUnitObj)
    External (_SB_.PLW2, FieldUnitObj)
    External (_SB_.PR00, ProcessorObj)
    External (_SB_.PR00._PSS, MethodObj)    // 0 Arguments
    External (_SB_.PR00._TPC, IntObj)
    External (_SB_.PR00._TSD, MethodObj)    // 0 Arguments
    External (_SB_.PR00._TSS, MethodObj)    // 0 Arguments
    External (_SB_.PR00.LPSS, PkgObj)
    External (_SB_.PR00.TPSS, PkgObj)
    External (_SB_.PR00.TSMC, PkgObj)
    External (_SB_.PR00.TSMF, PkgObj)
    External (_SB_.PR01, ProcessorObj)
    External (_SB_.PR02, ProcessorObj)
    External (_SB_.PR03, ProcessorObj)
    External (_SB_.PR04, ProcessorObj)
    External (_SB_.PR05, ProcessorObj)
    External (_SB_.PR06, ProcessorObj)
    External (_SB_.PR07, ProcessorObj)
    External (_SB_.PR08, ProcessorObj)
    External (_SB_.PR09, ProcessorObj)
    External (_SB_.PR10, ProcessorObj)
    External (_SB_.PR11, ProcessorObj)
    External (_SB_.PR12, ProcessorObj)
    External (_SB_.PR13, ProcessorObj)
    External (_SB_.PR14, ProcessorObj)
    External (_SB_.PR15, ProcessorObj)
    External (_SB_.PR16, ProcessorObj)
    External (_SB_.PR17, ProcessorObj)
    External (_SB_.PR18, ProcessorObj)
    External (_SB_.PR19, ProcessorObj)
    External (_SB_.SLPB, DeviceObj)
    External (_SB_.TAR0, FieldUnitObj)
    External (_SB_.TAR1, FieldUnitObj)
    External (_SB_.TAR2, FieldUnitObj)
    External (_TZ_.ETMD, IntObj)
    External (_TZ_.TZ00, ThermalZoneObj)
    External (_TZ_.TZ01, ThermalZoneObj)
    External (ACTT, IntObj)
    External (ADBG, MethodObj)    // 1 Arguments
    External (ATMC, IntObj)
    External (ATPC, IntObj)
    External (BATR, IntObj)
    External (CA2D, IntObj)
    External (CHGE, IntObj)
    External (CPUS, IntObj)
    External (CRTT, IntObj)
    External (CTDP, IntObj)
    External (DCFE, IntObj)
    External (DISE, IntObj)
    External (DPHL, IntObj)
    External (DPLL, IntObj)
    External (DPTF, IntObj)
    External (FND1, IntObj)
    External (HIDW, MethodObj)    // 4 Arguments
    External (HIWC, MethodObj)    // 1 Arguments
    External (LPER, IntObj)
    External (LPOE, IntObj)
    External (LPOP, IntObj)
    External (LPOS, IntObj)
    External (LPOW, IntObj)
    External (MPL0, IntObj)
    External (MPL1, IntObj)
    External (MPL2, IntObj)
    External (OCBS, IntObj)
    External (OCSS, IntObj)
    External (ODV0, IntObj)
    External (ODV1, IntObj)
    External (ODV2, IntObj)
    External (ODV3, IntObj)
    External (ODV4, IntObj)
    External (ODV5, IntObj)
    External (PC00, IntObj)
    External (PLID, UnknownObj)
    External (PNHM, IntObj)
    External (PPPR, IntObj)
    External (PPSZ, IntObj)
    External (PSVT, IntObj)
    External (PTMC, IntObj)
    External (PTPC, IntObj)
    External (PWRE, IntObj)
    External (PWRS, IntObj)
    External (S2AT, IntObj)
    External (S2CT, IntObj)
    External (S2DE, IntObj)
    External (S2HT, IntObj)
    External (S2PT, IntObj)
    External (S2S3, IntObj)
    External (S3AT, IntObj)
    External (S3CT, IntObj)
    External (S3DE, IntObj)
    External (S3HT, IntObj)
    External (S3PT, IntObj)
    External (S3S3, IntObj)
    External (S4AT, IntObj)
    External (S4CT, IntObj)
    External (S4DE, IntObj)
    External (S4HT, IntObj)
    External (S4PT, IntObj)
    External (S4S3, IntObj)
    External (S5AT, IntObj)
    External (S5CT, IntObj)
    External (S5DE, IntObj)
    External (S5HT, IntObj)
    External (S5PT, IntObj)
    External (S5S3, IntObj)
    External (SAC3, IntObj)
    External (SACT, IntObj)
    External (SADE, IntObj)
    External (SAHT, IntObj)
    External (SAT1, IntObj)
    External (SAT2, IntObj)
    External (SC31, IntObj)
    External (SC32, IntObj)
    External (SCT1, IntObj)
    External (SCT2, IntObj)
    External (SGE1, IntObj)
    External (SGE2, IntObj)
    External (SHT1, IntObj)
    External (SHT2, IntObj)
    External (SPT1, IntObj)
    External (SPT2, IntObj)
    External (SSP2, IntObj)
    External (SSP3, IntObj)
    External (SSP4, IntObj)
    External (SSP5, IntObj)
    External (TCNT, IntObj)
    External (THMP, IntObj)
    External (TJMX, IntObj)
    External (TSOD, IntObj)
    External (V1AT, IntObj)
    External (V1C3, IntObj)
    External (V1CR, IntObj)
    External (V1HT, IntObj)
    External (V1PV, IntObj)
    External (V2AT, IntObj)
    External (V2C3, IntObj)
    External (V2CR, IntObj)
    External (V2HT, IntObj)
    External (V2PV, IntObj)
    External (VSP1, IntObj)
    External (VSP2, IntObj)
    External (WAND, IntObj)
    External (WLC3, IntObj)
    External (WRAT, IntObj)
    External (WRCT, IntObj)
    External (WRFD, IntObj)
    External (WRHT, IntObj)
    External (WRPT, IntObj)
    External (WTSP, IntObj)
    External (WWAT, IntObj)
    External (WWC3, IntObj)
    External (WWCT, IntObj)
    External (WWHT, IntObj)
    External (WWPT, IntObj)

    Scope (\_SB)
    {
        Device (IETM)
        {
            Name (_HID, EisaId ("INT3400") /* Intel Dynamic Power Performance Management */)  // _HID: Hardware ID
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (CondRefOf (HIWC))
                {
                    If (HIWC (Arg0))
                    {
                        If (CondRefOf (HIDW))
                        {
                            Return (HIDW (Arg0, Arg1, Arg2, Arg3))
                        }
                    }
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DPTF == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (PTRP, Zero)
            Name (PSEM, Zero)
            Name (ATRP, Zero)
            Name (ASEM, Zero)
            Name (YTRP, Zero)
            Name (YSEM, Zero)
            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, STS1)
                CreateDWordField (Arg3, 0x04, CAP1)
                If ((Arg1 != One))
                {
                    STS1 &= 0xFFFFFF00
                    STS1 |= 0x0A
                    Return (Arg3)
                }

                If ((Arg2 != 0x02))
                {
                    STS1 &= 0xFFFFFF00
                    STS1 |= 0x02
                    Return (Arg3)
                }

                If (CondRefOf (\_SB.APSV))
                {
                    If ((PSEM == Zero))
                    {
                        PSEM = One
                        PTRP = \_SB.APSV /* External reference */
                    }
                }

                If (CondRefOf (\_SB.AAC0))
                {
                    If ((ASEM == Zero))
                    {
                        ASEM = One
                        ATRP = \_SB.AAC0 /* External reference */
                    }
                }

                If (CondRefOf (\_SB.ACRT))
                {
                    If ((YSEM == Zero))
                    {
                        YSEM = One
                        YTRP = \_SB.ACRT /* External reference */
                    }
                }

                If ((Arg0 == ToUUID ("b23ba85d-c8b7-3542-88de-8de2ffcfd698")))
                {
                    If (~(STS1 & One))
                    {
                        If ((CAP1 & One))
                        {
                            If ((CAP1 & 0x02))
                            {
                                \_SB.AAC0 = 0x6E
                                \_TZ.ETMD = Zero
                            }
                            Else
                            {
                                \_SB.AAC0 = ATRP /* \_SB_.IETM.ATRP */
                                \_TZ.ETMD = One
                            }

                            If ((CAP1 & 0x04))
                            {
                                \_SB.APSV = 0x6E
                            }
                            Else
                            {
                                \_SB.APSV = PTRP /* \_SB_.IETM.PTRP */
                            }

                            If ((CAP1 & 0x08))
                            {
                                \_SB.ACRT = 0xD2
                            }
                            Else
                            {
                                \_SB.ACRT = YTRP /* \_SB_.IETM.YTRP */
                            }
                        }
                        Else
                        {
                            \_SB.ACRT = YTRP /* \_SB_.IETM.YTRP */
                            \_SB.APSV = PTRP /* \_SB_.IETM.PTRP */
                            \_SB.AAC0 = ATRP /* \_SB_.IETM.ATRP */
                            \_TZ.ETMD = One
                        }

                        If (CondRefOf (\_TZ.TZ00))
                        {
                            Notify (\_TZ.TZ00, 0x81) // Information Change
                        }
                    }

                    Return (Arg3)
                }

                Return (Arg3)
            }

            Method (DCFG, 0, NotSerialized)
            {
                Return (\DCFE) /* External reference */
            }

            Name (ODVX, Package (0x06)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Method (ODVP, 0, Serialized)
            {
                ODVX [Zero] = \ODV0 /* External reference */
                ODVX [One] = \ODV1 /* External reference */
                ODVX [0x02] = \ODV2 /* External reference */
                ODVX [0x03] = \ODV3 /* External reference */
                ODVX [0x04] = \ODV4 /* External reference */
                ODVX [0x05] = \ODV5 /* External reference */
                Return (ODVX) /* \_SB_.IETM.ODVX */
            }
        }
    }

    Scope (\_SB.IETM)
    {
        Method (KTOC, 1, Serialized)
        {
            If ((Arg0 > 0x0AAC))
            {
                Return (((Arg0 - 0x0AAC) / 0x0A))
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (CTOK, 1, Serialized)
        {
            Return (((Arg0 * 0x0A) + 0x0AAC))
        }

        Method (C10K, 1, Serialized)
        {
            Name (TMP1, Buffer (0x10)
            {
                 0x00                                             // .
            })
            CreateByteField (TMP1, Zero, TMPL)
            CreateByteField (TMP1, One, TMPH)
            Local0 = (Arg0 + 0x0AAC)
            TMPL = (Local0 & 0xFF)
            TMPH = ((Local0 & 0xFF00) >> 0x08)
            ToInteger (TMP1, Local1)
            Return (Local1)
        }

        Method (K10C, 1, Serialized)
        {
            If ((Arg0 > 0x0AAC))
            {
                Return ((Arg0 - 0x0AAC))
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Scope (\_SB.PCI0.B0D4)
    {
        Name (PFLG, Zero)
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If ((\SADE == One))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }

        OperationRegion (MBAR, SystemMemory, ((MHBR << 0x0F) + 0x5000), 0x1000)
        Field (MBAR, ByteAcc, NoLock, Preserve)
        {
            Offset (0x930), 
            PTDP,   15, 
            Offset (0x932), 
            PMIN,   15, 
            Offset (0x934), 
            PMAX,   15, 
            Offset (0x936), 
            TMAX,   7, 
            Offset (0x938), 
            PWRU,   4, 
            Offset (0x939), 
            EGYU,   5, 
            Offset (0x93A), 
            TIMU,   4, 
            Offset (0x958), 
            Offset (0x95C), 
            LPMS,   1, 
            CTNL,   2, 
            Offset (0x978), 
            PCTP,   8, 
            Offset (0x998), 
            RP0C,   8, 
            RP1C,   8, 
            RPNC,   8, 
            Offset (0xF3C), 
            TRAT,   8, 
            Offset (0xF40), 
            PTD1,   15, 
            Offset (0xF42), 
            TRA1,   8, 
            Offset (0xF44), 
            PMX1,   15, 
            Offset (0xF46), 
            PMN1,   15, 
            Offset (0xF48), 
            PTD2,   15, 
            Offset (0xF4A), 
            TRA2,   8, 
            Offset (0xF4C), 
            PMX2,   15, 
            Offset (0xF4E), 
            PMN2,   15, 
            Offset (0xF50), 
            CTCL,   2, 
                ,   29, 
            CLCK,   1, 
            MNTR,   8
        }

        Name (XPCC, Zero)
        Method (PPCC, 0, Serialized)
        {
            If (((XPCC == Zero) && CondRefOf (\_SB.CBMI)))
            {
                Switch (ToInteger (\_SB.CBMI))
                {
                    Case (Zero)
                    {
                        If (((\_SB.CLVL >= One) && (\_SB.CLVL <= 0x03)))
                        {
                            CPL0 ()
                            XPCC = One
                        }
                    }
                    Case (One)
                    {
                        If (((\_SB.CLVL == 0x02) || (\_SB.CLVL == 0x03)))
                        {
                            CPL1 ()
                            XPCC = One
                        }
                    }
                    Case (0x02)
                    {
                        If ((\_SB.CLVL == 0x03))
                        {
                            CPL2 ()
                            XPCC = One
                        }
                    }

                }
            }

            Return (NPCC) /* \_SB_.PCI0.B0D4.NPCC */
        }

        Name (NPCC, Package (0x03)
        {
            0x02, 
            Package (0x06)
            {
                Zero, 
                0x88B8, 
                0xAFC8, 
                0x6D60, 
                0x7D00, 
                0x03E8
            }, 

            Package (0x06)
            {
                One, 
                0xDBBA, 
                0xDBBA, 
                Zero, 
                Zero, 
                0x03E8
            }
        })
        Method (CPNU, 2, Serialized)
        {
            Name (CNVT, Zero)
            Name (PPUU, Zero)
            Name (RMDR, Zero)
            If ((PWRU == Zero))
            {
                PPUU = One
            }
            Else
            {
                PPUU = (PWRU-- << 0x02)
            }

            Divide (Arg0, PPUU, RMDR, CNVT) /* \_SB_.PCI0.B0D4.CPNU.CNVT */
            If ((Arg1 == Zero))
            {
                Return (CNVT) /* \_SB_.PCI0.B0D4.CPNU.CNVT */
            }
            Else
            {
                CNVT *= 0x03E8
                RMDR *= 0x03E8
                RMDR /= PPUU
                CNVT += RMDR /* \_SB_.PCI0.B0D4.CPNU.RMDR */
                Return (CNVT) /* \_SB_.PCI0.B0D4.CPNU.CNVT */
            }
        }

        Method (CPL0, 0, NotSerialized)
        {
            \_SB.PCI0.B0D4.NPCC [Zero] = 0x02
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [Zero] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [One] = \MPL0 /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x02] = CPNU (\_SB.PL10, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x03] = (\_SB.PLW0 * 0x03E8)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x04] = ((\_SB.PLW0 * 0x03E8
                ) + 0x0FA0)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x05] = PPSZ /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [Zero] = One
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [One] = CPNU (\_SB.PL20, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x02] = CPNU (\_SB.PL20, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x03] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x04] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x05] = PPSZ /* External reference */
        }

        Method (CPL1, 0, NotSerialized)
        {
            \_SB.PCI0.B0D4.NPCC [Zero] = 0x02
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [Zero] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [One] = \MPL1 /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x02] = CPNU (\_SB.PL11, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x03] = (\_SB.PLW1 * 0x03E8)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x04] = ((\_SB.PLW1 * 0x03E8
                ) + 0x0FA0)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x05] = PPSZ /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [Zero] = One
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [One] = CPNU (\_SB.PL21, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x02] = CPNU (\_SB.PL21, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x03] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x04] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x05] = PPSZ /* External reference */
        }

        Method (CPL2, 0, NotSerialized)
        {
            \_SB.PCI0.B0D4.NPCC [Zero] = 0x02
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [Zero] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [One] = \MPL2 /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x02] = CPNU (\_SB.PL12, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x03] = (\_SB.PLW2 * 0x03E8)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x04] = ((\_SB.PLW2 * 0x03E8
                ) + 0x0FA0)
            DerefOf (\_SB.PCI0.B0D4.NPCC [One]) [0x05] = PPSZ /* External reference */
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [Zero] = One
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [One] = CPNU (\_SB.PL22, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x02] = CPNU (\_SB.PL22, One)
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x03] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x04] = Zero
            DerefOf (\_SB.PCI0.B0D4.NPCC [0x02]) [0x05] = PPSZ /* External reference */
        }

        Name (LSTM, Zero)
        Name (_PPC, Zero)  // _PPC: Performance Present Capabilities
        Method (SPPC, 1, Serialized)
        {
            If (CondRefOf (\_SB.CPPC))
            {
                \_SB.CPPC = Arg0
            }

            Switch (ToInteger (\TCNT))
            {
                Case (0x14)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                    Notify (\_SB.PR14, 0x80) // Status Change
                    Notify (\_SB.PR15, 0x80) // Status Change
                    Notify (\_SB.PR16, 0x80) // Status Change
                    Notify (\_SB.PR17, 0x80) // Status Change
                    Notify (\_SB.PR18, 0x80) // Status Change
                    Notify (\_SB.PR19, 0x80) // Status Change
                }
                Case (0x13)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                    Notify (\_SB.PR14, 0x80) // Status Change
                    Notify (\_SB.PR15, 0x80) // Status Change
                    Notify (\_SB.PR16, 0x80) // Status Change
                    Notify (\_SB.PR17, 0x80) // Status Change
                    Notify (\_SB.PR18, 0x80) // Status Change
                }
                Case (0x12)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                    Notify (\_SB.PR14, 0x80) // Status Change
                    Notify (\_SB.PR15, 0x80) // Status Change
                    Notify (\_SB.PR16, 0x80) // Status Change
                    Notify (\_SB.PR17, 0x80) // Status Change
                }
                Case (0x11)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                    Notify (\_SB.PR14, 0x80) // Status Change
                    Notify (\_SB.PR15, 0x80) // Status Change
                    Notify (\_SB.PR16, 0x80) // Status Change
                }
                Case (0x10)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                    Notify (\_SB.PR14, 0x80) // Status Change
                    Notify (\_SB.PR15, 0x80) // Status Change
                }
                Case (0x0E)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                    Notify (\_SB.PR12, 0x80) // Status Change
                    Notify (\_SB.PR13, 0x80) // Status Change
                }
                Case (0x0C)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                    Notify (\_SB.PR10, 0x80) // Status Change
                    Notify (\_SB.PR11, 0x80) // Status Change
                }
                Case (0x0A)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                    Notify (\_SB.PR08, 0x80) // Status Change
                    Notify (\_SB.PR09, 0x80) // Status Change
                }
                Case (0x08)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                    Notify (\_SB.PR07, 0x80) // Status Change
                }
                Case (0x07)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                    Notify (\_SB.PR06, 0x80) // Status Change
                }
                Case (0x06)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                    Notify (\_SB.PR05, 0x80) // Status Change
                }
                Case (0x05)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                    Notify (\_SB.PR04, 0x80) // Status Change
                }
                Case (0x04)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                    Notify (\_SB.PR03, 0x80) // Status Change
                }
                Case (0x03)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                    Notify (\_SB.PR02, 0x80) // Status Change
                }
                Case (0x02)
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                    Notify (\_SB.PR01, 0x80) // Status Change
                }
                Default
                {
                    Notify (\_SB.PR00, 0x80) // Status Change
                }

            }
        }

        Name (TLPO, Package (0x06)
        {
            One, 
            One, 
            Zero, 
            One, 
            One, 
            0x02
        })
        Method (CLPO, 0, NotSerialized)
        {
            TLPO [One] = LPOE /* External reference */
            If (CondRefOf (\_SB.PR00._PSS))
            {
                If ((\_SB.OSCP & 0x0400))
                {
                    Local1 = SizeOf (\_SB.PR00.TPSS)
                }
                Else
                {
                    Local1 = SizeOf (\_SB.PR00.LPSS)
                }
            }
            Else
            {
                Local1 = Zero
            }

            If ((LPOP < Local1))
            {
                TLPO [0x02] = LPOP /* External reference */
            }
            Else
            {
                Local1--
                TLPO [0x02] = Local1
            }

            TLPO [0x03] = LPOS /* External reference */
            TLPO [0x04] = LPOW /* External reference */
            TLPO [0x05] = LPER /* External reference */
            Return (TLPO) /* \_SB_.PCI0.B0D4.TLPO */
        }

        Method (SPUR, 1, NotSerialized)
        {
            If ((Arg0 <= \TCNT))
            {
                If ((\_SB.PAGD._STA () == 0x0F))
                {
                    \_SB.PAGD._PUR [One] = Arg0
                    Notify (\_SB.PAGD, 0x80) // Status Change
                }
            }
        }

        Name (AEXL, Package (0x04)
        {
            "svchost.exe", 
            "dllhost.exe", 
            "smss.exe", 
            "WinSAT.exe"
        })
        Method (PCCC, 0, Serialized)
        {
            PCCX [Zero] = One
            Switch (ToInteger (CPNU (PTDP, Zero)))
            {
                Case (0x39)
                {
                    DerefOf (PCCX [One]) [Zero] = 0xA7F8
                    DerefOf (PCCX [One]) [One] = 0x00017318
                }
                Case (0x2F)
                {
                    DerefOf (PCCX [One]) [Zero] = 0x9858
                    DerefOf (PCCX [One]) [One] = 0x00014C08
                }
                Case (0x25)
                {
                    DerefOf (PCCX [One]) [Zero] = 0x7148
                    DerefOf (PCCX [One]) [One] = 0xD6D8
                }
                Case (0x19)
                {
                    DerefOf (PCCX [One]) [Zero] = 0x3E80
                    DerefOf (PCCX [One]) [One] = 0x7D00
                }
                Case (0x0F)
                {
                    DerefOf (PCCX [One]) [Zero] = 0x36B0
                    DerefOf (PCCX [One]) [One] = 0x7D00
                }
                Case (0x0B)
                {
                    DerefOf (PCCX [One]) [Zero] = 0x36B0
                    DerefOf (PCCX [One]) [One] = 0x61A8
                }
                Default
                {
                    DerefOf (PCCX [One]) [Zero] = 0xFF
                    DerefOf (PCCX [One]) [One] = 0xFF
                }

            }

            Return (PCCX) /* \_SB_.PCI0.B0D4.PCCX */
        }

        Name (PCCX, Package (0x02)
        {
            0x80000000, 
            Package (0x02)
            {
                0x80000000, 
                0x80000000
            }
        })
        Name (KEFF, Package (0x1E)
        {
            Package (0x02)
            {
                0x01BC, 
                Zero
            }, 

            Package (0x02)
            {
                0x01CF, 
                0x27
            }, 

            Package (0x02)
            {
                0x01E1, 
                0x4B
            }, 

            Package (0x02)
            {
                0x01F3, 
                0x6C
            }, 

            Package (0x02)
            {
                0x0206, 
                0x8B
            }, 

            Package (0x02)
            {
                0x0218, 
                0xA8
            }, 

            Package (0x02)
            {
                0x022A, 
                0xC3
            }, 

            Package (0x02)
            {
                0x023D, 
                0xDD
            }, 

            Package (0x02)
            {
                0x024F, 
                0xF4
            }, 

            Package (0x02)
            {
                0x0261, 
                0x010B
            }, 

            Package (0x02)
            {
                0x0274, 
                0x011F
            }, 

            Package (0x02)
            {
                0x032C, 
                0x01BD
            }, 

            Package (0x02)
            {
                0x03D7, 
                0x0227
            }, 

            Package (0x02)
            {
                0x048B, 
                0x026D
            }, 

            Package (0x02)
            {
                0x053E, 
                0x02A1
            }, 

            Package (0x02)
            {
                0x05F7, 
                0x02C6
            }, 

            Package (0x02)
            {
                0x06A8, 
                0x02E6
            }, 

            Package (0x02)
            {
                0x075D, 
                0x02FF
            }, 

            Package (0x02)
            {
                0x0818, 
                0x0311
            }, 

            Package (0x02)
            {
                0x08CF, 
                0x0322
            }, 

            Package (0x02)
            {
                0x179C, 
                0x0381
            }, 

            Package (0x02)
            {
                0x2DDC, 
                0x039C
            }, 

            Package (0x02)
            {
                0x44A8, 
                0x039E
            }, 

            Package (0x02)
            {
                0x5C35, 
                0x0397
            }, 

            Package (0x02)
            {
                0x747D, 
                0x038D
            }, 

            Package (0x02)
            {
                0x8D7F, 
                0x0382
            }, 

            Package (0x02)
            {
                0xA768, 
                0x0376
            }, 

            Package (0x02)
            {
                0xC23B, 
                0x0369
            }, 

            Package (0x02)
            {
                0xDE26, 
                0x035A
            }, 

            Package (0x02)
            {
                0xFB7C, 
                0x034A
            }
        })
        Name (CEUP, Package (0x06)
        {
            0x80000000, 
            0x80000000, 
            0x80000000, 
            0x80000000, 
            0x80000000, 
            0x80000000
        })
        Method (TMPX, 0, Serialized)
        {
            Return (\_SB.IETM.CTOK (PCTP))
        }

        Method (_DTI, 1, NotSerialized)  // _DTI: Device Temperature Indication
        {
            LSTM = Arg0
            Notify (\_SB.PCI0.B0D4, 0x91) // Device-Specific
        }

        Method (_NTT, 0, NotSerialized)  // _NTT: Notification Temperature Threshold
        {
            Return (0x0ADE)
        }

        Name (PTYP, Zero)
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If (CondRefOf (\_SB.PR00._PSS))
            {
                Return (\_SB.PR00._PSS ())
            }
            Else
            {
                Return (Package (0x02)
                {
                    Package (0x06)
                    {
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero
                    }, 

                    Package (0x06)
                    {
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero
                    }
                })
            }
        }

        Method (_TSS, 0, NotSerialized)  // _TSS: Throttling Supported States
        {
            If (CondRefOf (\_SB.PR00._TSS))
            {
                Return (\_SB.PR00._TSS ())
            }
            Else
            {
                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        One, 
                        Zero, 
                        Zero, 
                        Zero, 
                        Zero
                    }
                })
            }
        }

        Method (_TPC, 0, NotSerialized)  // _TPC: Throttling Present Capabilities
        {
            If (CondRefOf (\_SB.PR00._TPC))
            {
                Return (\_SB.PR00._TPC) /* External reference */
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_PTC, 0, NotSerialized)  // _PTC: Processor Throttling Control
        {
            If ((CondRefOf (\PC00) && (\PC00 != 0x80000000)))
            {
                If ((\PC00 & 0x04))
                {
                    Return (Package (0x02)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }
                    })
                }
                Else
                {
                    Return (Package (0x02)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x05,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001810, // Address
                                ,)
                        }, 

                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x05,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000001810, // Address
                                ,)
                        }
                    })
                }
            }
            Else
            {
                Return (Package (0x02)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }, 

                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x00,               // Bit Width
                            0x00,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }
                })
            }
        }

        Method (_TSD, 0, NotSerialized)  // _TSD: Throttling State Dependencies
        {
            If (CondRefOf (\_SB.PR00._TSD))
            {
                Return (\_SB.PR00._TSD ())
            }
            Else
            {
                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        Zero, 
                        Zero, 
                        0xFC, 
                        Zero
                    }
                })
            }
        }

        Method (_TDL, 0, NotSerialized)  // _TDL: T-State Depth Limit
        {
            If ((CondRefOf (\_SB.PR00._TSS) && CondRefOf (\_SB.CFGD)))
            {
                If ((\_SB.CFGD & 0x2000))
                {
                    Return ((SizeOf (\_SB.PR00.TSMF) - One))
                }
                Else
                {
                    Return ((SizeOf (\_SB.PR00.TSMC) - One))
                }
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_PDL, 0, NotSerialized)  // _PDL: P-state Depth Limit
        {
            If (CondRefOf (\_SB.PR00._PSS))
            {
                If ((\_SB.OSCP & 0x0400))
                {
                    Return ((SizeOf (\_SB.PR00.TPSS) - One))
                }
                Else
                {
                    Return ((SizeOf (\_SB.PR00.LPSS) - One))
                }
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
        {
            Return (\CPUS) /* External reference */
        }

        Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
        {
            If ((\ATMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Local1 = \_SB.IETM.CTOK (\ATMC)
            If ((LSTM >= Local1))
            {
                Return ((Local1 - 0x14))
            }
            Else
            {
                Return (Local1)
            }
        }

        Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
        {
            If ((\ATMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Local0 = \_SB.IETM.CTOK (\ATMC)
            Local0 -= 0x32
            If ((LSTM >= Local0))
            {
                Return ((Local0 - 0x14))
            }
            Else
            {
                Return (Local0)
            }
        }

        Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
        {
            If ((\ATMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Local0 = \_SB.IETM.CTOK (\ATMC)
            Local0 -= 0x64
            If ((LSTM >= Local0))
            {
                Return ((Local0 - 0x14))
            }
            Else
            {
                Return (Local0)
            }
        }

        Method (_AC3, 0, Serialized)  // _ACx: Active Cooling, x=0-9
        {
            If ((\ATMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Local0 = \_SB.IETM.CTOK (\ATMC)
            Local0 -= 0x96
            If ((LSTM >= Local0))
            {
                Return ((Local0 - 0x14))
            }
            Else
            {
                Return (Local0)
            }
        }

        Method (_AC4, 0, Serialized)  // _ACx: Active Cooling, x=0-9
        {
            If ((\ATMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Local0 = \_SB.IETM.CTOK (\ATMC)
            Local0 -= 0xC8
            If ((LSTM >= Local0))
            {
                Return ((Local0 - 0x14))
            }
            Else
            {
                Return (Local0)
            }
        }

        Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
        {
            If ((\PTMC == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Return (\_SB.IETM.CTOK (\PTMC))
        }

        Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
        {
            If ((\SACT == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Return (\_SB.IETM.CTOK (\SACT))
        }

        Method (_CR3, 0, Serialized)  // _CR3: Warm/Standby Temperature
        {
            If ((\SAC3 == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Return (\_SB.IETM.CTOK (\SAC3))
        }

        Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
        {
            If ((\SAHT == Zero))
            {
                Return (0xFFFFFFFF)
            }

            Return (\_SB.IETM.CTOK (\SAHT))
        }

        Method (UVTH, 1, Serialized)
        {
        }
    }

    Scope (\_SB.IETM)
    {
        Name (CTSP, Package (0x01)
        {
            ToUUID ("e145970a-e4c1-4d73-900e-c9c5a69dd067")
        })
    }

    Scope (\_SB.PCI0.B0D4)
    {
        Method (TDPL, 0, Serialized)
        {
            Name (AAAA, Zero)
            Name (BBBB, Zero)
            Name (CCCC, Zero)
            Local0 = CTNL /* \_SB_.PCI0.B0D4.CTNL */
            If (((Local0 == One) || (Local0 == 0x02)))
            {
                Local0 = \_SB.CLVL /* External reference */
            }
            Else
            {
                Return (Package (0x01)
                {
                    Zero
                })
            }

            If ((CLCK == One))
            {
                Local0 = One
            }

            AAAA = CPNU (\_SB.PL10, One)
            BBBB = CPNU (\_SB.PL11, One)
            CCCC = CPNU (\_SB.PL12, One)
            Name (TMP1, Package (0x01)
            {
                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }
            })
            Name (TMP2, Package (0x02)
            {
                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }, 

                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }
            })
            Name (TMP3, Package (0x03)
            {
                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }, 

                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }, 

                Package (0x05)
                {
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000, 
                    0x80000000
                }
            })
            If ((Local0 == 0x03))
            {
                If ((AAAA > BBBB))
                {
                    If ((AAAA > CCCC))
                    {
                        If ((BBBB > CCCC))
                        {
                            Local3 = Zero
                            LEV0 = Zero
                            Local4 = One
                            LEV1 = One
                            Local5 = 0x02
                            LEV2 = 0x02
                        }
                        Else
                        {
                            Local3 = Zero
                            LEV0 = Zero
                            Local5 = One
                            LEV1 = 0x02
                            Local4 = 0x02
                            LEV2 = One
                        }
                    }
                    Else
                    {
                        Local5 = Zero
                        LEV0 = 0x02
                        Local3 = One
                        LEV1 = Zero
                        Local4 = 0x02
                        LEV2 = One
                    }
                }
                ElseIf ((BBBB > CCCC))
                {
                    If ((AAAA > CCCC))
                    {
                        Local4 = Zero
                        LEV0 = One
                        Local3 = One
                        LEV1 = Zero
                        Local5 = 0x02
                        LEV2 = 0x02
                    }
                    Else
                    {
                        Local4 = Zero
                        LEV0 = One
                        Local5 = One
                        LEV1 = 0x02
                        Local3 = 0x02
                        LEV2 = Zero
                    }
                }
                Else
                {
                    Local5 = Zero
                    LEV0 = 0x02
                    Local4 = One
                    LEV1 = One
                    Local3 = 0x02
                    LEV2 = Zero
                }

                Local1 = (\_SB.TAR0 + One)
                Local2 = (Local1 * 0x64)
                DerefOf (TMP3 [Local3]) [Zero] = AAAA /* \_SB_.PCI0.B0D4.TDPL.AAAA */
                DerefOf (TMP3 [Local3]) [One] = Local2
                DerefOf (TMP3 [Local3]) [0x02] = \_SB.CTC0 /* External reference */
                DerefOf (TMP3 [Local3]) [0x03] = Local1
                DerefOf (TMP3 [Local3]) [0x04] = Zero
                Local1 = (\_SB.TAR1 + One)
                Local2 = (Local1 * 0x64)
                DerefOf (TMP3 [Local4]) [Zero] = BBBB /* \_SB_.PCI0.B0D4.TDPL.BBBB */
                DerefOf (TMP3 [Local4]) [One] = Local2
                DerefOf (TMP3 [Local4]) [0x02] = \_SB.CTC1 /* External reference */
                DerefOf (TMP3 [Local4]) [0x03] = Local1
                DerefOf (TMP3 [Local4]) [0x04] = Zero
                Local1 = (\_SB.TAR2 + One)
                Local2 = (Local1 * 0x64)
                DerefOf (TMP3 [Local5]) [Zero] = CCCC /* \_SB_.PCI0.B0D4.TDPL.CCCC */
                DerefOf (TMP3 [Local5]) [One] = Local2
                DerefOf (TMP3 [Local5]) [0x02] = \_SB.CTC2 /* External reference */
                DerefOf (TMP3 [Local5]) [0x03] = Local1
                DerefOf (TMP3 [Local5]) [0x04] = Zero
                Return (TMP3) /* \_SB_.PCI0.B0D4.TDPL.TMP3 */
            }

            If ((Local0 == 0x02))
            {
                If ((AAAA > BBBB))
                {
                    Local3 = Zero
                    Local4 = One
                    LEV0 = Zero
                    LEV1 = One
                    LEV2 = Zero
                }
                Else
                {
                    Local4 = Zero
                    Local3 = One
                    LEV0 = One
                    LEV1 = Zero
                    LEV2 = Zero
                }

                Local1 = (\_SB.TAR0 + One)
                Local2 = (Local1 * 0x64)
                DerefOf (TMP2 [Local3]) [Zero] = AAAA /* \_SB_.PCI0.B0D4.TDPL.AAAA */
                DerefOf (TMP2 [Local3]) [One] = Local2
                DerefOf (TMP2 [Local3]) [0x02] = \_SB.CTC0 /* External reference */
                DerefOf (TMP2 [Local3]) [0x03] = Local1
                DerefOf (TMP2 [Local3]) [0x04] = Zero
                Local1 = (\_SB.TAR1 + One)
                Local2 = (Local1 * 0x64)
                DerefOf (TMP2 [Local4]) [Zero] = BBBB /* \_SB_.PCI0.B0D4.TDPL.BBBB */
                DerefOf (TMP2 [Local4]) [One] = Local2
                DerefOf (TMP2 [Local4]) [0x02] = \_SB.CTC1 /* External reference */
                DerefOf (TMP2 [Local4]) [0x03] = Local1
                DerefOf (TMP2 [Local4]) [0x04] = Zero
                Return (TMP2) /* \_SB_.PCI0.B0D4.TDPL.TMP2 */
            }

            If ((Local0 == One))
            {
                Switch (ToInteger (\_SB.CBMI))
                {
                    Case (Zero)
                    {
                        Local1 = (\_SB.TAR0 + One)
                        Local2 = (Local1 * 0x64)
                        DerefOf (TMP1 [Zero]) [Zero] = AAAA /* \_SB_.PCI0.B0D4.TDPL.AAAA */
                        DerefOf (TMP1 [Zero]) [One] = Local2
                        DerefOf (TMP1 [Zero]) [0x02] = \_SB.CTC0 /* External reference */
                        DerefOf (TMP1 [Zero]) [0x03] = Local1
                        DerefOf (TMP1 [Zero]) [0x04] = Zero
                        LEV0 = Zero
                        LEV1 = Zero
                        LEV2 = Zero
                    }
                    Case (One)
                    {
                        Local1 = (\_SB.TAR1 + One)
                        Local2 = (Local1 * 0x64)
                        DerefOf (TMP1 [Zero]) [Zero] = BBBB /* \_SB_.PCI0.B0D4.TDPL.BBBB */
                        DerefOf (TMP1 [Zero]) [One] = Local2
                        DerefOf (TMP1 [Zero]) [0x02] = \_SB.CTC1 /* External reference */
                        DerefOf (TMP1 [Zero]) [0x03] = Local1
                        DerefOf (TMP1 [Zero]) [0x04] = Zero
                        LEV0 = One
                        LEV1 = One
                        LEV2 = One
                    }
                    Case (0x02)
                    {
                        Local1 = (\_SB.TAR2 + One)
                        Local2 = (Local1 * 0x64)
                        DerefOf (TMP1 [Zero]) [Zero] = CCCC /* \_SB_.PCI0.B0D4.TDPL.CCCC */
                        DerefOf (TMP1 [Zero]) [One] = Local2
                        DerefOf (TMP1 [Zero]) [0x02] = \_SB.CTC2 /* External reference */
                        DerefOf (TMP1 [Zero]) [0x03] = Local1
                        DerefOf (TMP1 [Zero]) [0x04] = Zero
                        LEV0 = 0x02
                        LEV1 = 0x02
                        LEV2 = 0x02
                    }

                }

                Return (TMP1) /* \_SB_.PCI0.B0D4.TDPL.TMP1 */
            }

            Return (Zero)
        }

        Name (MAXT, Zero)
        Method (TDPC, 0, NotSerialized)
        {
            Return (MAXT) /* \_SB_.PCI0.B0D4.MAXT */
        }

        Name (LEV0, Zero)
        Name (LEV1, Zero)
        Name (LEV2, Zero)
        Method (STDP, 1, Serialized)
        {
            If ((Arg0 >= \_SB.CLVL))
            {
                Return (Zero)
            }

            Switch (ToInteger (Arg0))
            {
                Case (Zero)
                {
                    Local0 = LEV0 /* \_SB_.PCI0.B0D4.LEV0 */
                }
                Case (One)
                {
                    Local0 = LEV1 /* \_SB_.PCI0.B0D4.LEV1 */
                }
                Case (0x02)
                {
                    Local0 = LEV2 /* \_SB_.PCI0.B0D4.LEV2 */
                }

            }

            Switch (ToInteger (Local0))
            {
                Case (Zero)
                {
                    CPL0 ()
                }
                Case (One)
                {
                    CPL1 ()
                }
                Case (0x02)
                {
                    CPL2 ()
                }

            }

            Notify (\_SB.PCI0.B0D4, 0x83) // Device-Specific Change
        }
    }

    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Device (SEN2)
        {
            Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
            Name (_UID, "SEN2")  // _UID: Unique ID
            Name (_STR, Unicode ("CPU VR"))  // _STR: Description String
            Name (PTYP, 0x03)
            Name (CTYP, Zero)
            Name (PFLG, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((\S2DE == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (\_SB.PCI0.LPCB.ECOK ())
                {
                    Return (\_SB.IETM.CTOK (\_SB.PCI0.LPCB.EC0.EST1))
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Name (GTSH, 0x14)
            Name (LSTM, Zero)
            Method (_DTI, 1, NotSerialized)  // _DTI: Device Temperature Indication
            {
                LSTM = Arg0
                Notify (\_SB.PCI0.LPCB.EC0.SEN2, 0x91) // Device-Specific
            }

            Method (_NTT, 0, NotSerialized)  // _NTT: Notification Temperature Threshold
            {
                Return (0x0ADE)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (\SSP2) /* External reference */
            }

            Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S2PT)
                }
                Else
                {
                    If ((\S2AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S2AT)
                }

                If ((LSTM >= Local1))
                {
                    Return ((Local1 - 0x14))
                }
                Else
                {
                    Return (Local1)
                }
            }

            Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC0 () - 0x64))
            }

            Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC1 () - 0x64))
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If (CTYP)
                {
                    If ((\S2AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S2AT))
                }
                Else
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S2PT))
                }
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If ((\S2CT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S2CT))
            }

            Method (_CR3, 0, Serialized)  // _CR3: Warm/Standby Temperature
            {
                If ((\S2S3 == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S2S3))
            }

            Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
            {
                If ((\S2HT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S2HT))
            }
        }
    }

    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Device (SEN3)
        {
            Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
            Name (_UID, "SEN3")  // _UID: Unique ID
            Name (_STR, Unicode ("GPU VR"))  // _STR: Description String
            Name (PTYP, 0x03)
            Name (CTYP, Zero)
            Name (PFLG, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((\S3DE == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (\_SB.PCI0.LPCB.ECOK ())
                {
                    Return (\_SB.IETM.CTOK (\_SB.PCI0.LPCB.EC0.EST2))
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Name (GTSH, 0x14)
            Name (LSTM, Zero)
            Method (_DTI, 1, NotSerialized)  // _DTI: Device Temperature Indication
            {
                LSTM = Arg0
                Notify (\_SB.PCI0.LPCB.EC0.SEN3, 0x91) // Device-Specific
            }

            Method (_NTT, 0, NotSerialized)  // _NTT: Notification Temperature Threshold
            {
                Return (0x0ADE)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (\SSP3) /* External reference */
            }

            Method (_AC3, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S3PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S3PT)
                }
                Else
                {
                    If ((\S3AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S3AT)
                }

                If ((LSTM >= Local1))
                {
                    Return ((Local1 - 0x14))
                }
                Else
                {
                    Return (Local1)
                }
            }

            Method (_AC4, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S3PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S3AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC3 () - 0x64))
            }

            Method (_AC5, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S3PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S3AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC4 () - 0x64))
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If (CTYP)
                {
                    If ((\S3AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S3AT))
                }
                Else
                {
                    If ((\S3PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S3PT))
                }
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If ((\S3CT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S3CT))
            }

            Method (_CR3, 0, Serialized)  // _CR3: Warm/Standby Temperature
            {
                If ((\S3S3 == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S3S3))
            }

            Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
            {
                If ((\S3HT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S3HT))
            }
        }
    }

    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Device (SEN4)
        {
            Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
            Name (_UID, "SEN4")  // _UID: Unique ID
            Name (_STR, Unicode ("SSD"))  // _STR: Description String
            Name (PTYP, 0x03)
            Name (CTYP, Zero)
            Name (PFLG, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((\S4DE == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (\_SB.PCI0.LPCB.ECOK ())
                {
                    Return (\_SB.IETM.CTOK (\_SB.PCI0.LPCB.EC0.EST3))
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Name (GTSH, 0x14)
            Name (LSTM, Zero)
            Method (_DTI, 1, NotSerialized)  // _DTI: Device Temperature Indication
            {
                LSTM = Arg0
                Notify (\_SB.PCI0.LPCB.EC0.SEN4, 0x91) // Device-Specific
            }

            Method (_NTT, 0, NotSerialized)  // _NTT: Notification Temperature Threshold
            {
                Return (0x0ADE)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (\SSP4) /* External reference */
            }

            Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S4PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S4PT)
                }
                Else
                {
                    If ((\S4AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S4AT)
                }

                If ((LSTM >= Local1))
                {
                    Return ((Local1 - 0x14))
                }
                Else
                {
                    Return (Local1)
                }
            }

            Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC0 () - 0x64))
            }

            Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC1 () - 0x64))
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If (CTYP)
                {
                    If ((\S4AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S4AT))
                }
                Else
                {
                    If ((\S4PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S4PT))
                }
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If ((\S4CT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S4CT))
            }

            Method (_CR3, 0, Serialized)  // _CR3: Warm/Standby Temperature
            {
                If ((\S4S3 == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S4S3))
            }

            Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
            {
                If ((\S4HT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S4HT))
            }
        }
    }

    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Device (SEN5)
        {
            Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
            Name (_UID, "SEN5")  // _UID: Unique ID
            Name (_STR, Unicode ("GPU DTS"))  // _STR: Description String
            Name (PTYP, 0x03)
            Name (CTYP, Zero)
            Name (PFLG, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((\S5DE == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (\_SB.PCI0.LPCB.ECOK ())
                {
                    Return (\_SB.IETM.CTOK (\_SB.PCI0.LPCB.EC0.SKTC))
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Name (GTSH, 0x14)
            Name (LSTM, Zero)
            Method (_DTI, 1, NotSerialized)  // _DTI: Device Temperature Indication
            {
                LSTM = Arg0
                Notify (\_SB.PCI0.LPCB.EC0.SEN5, 0x91) // Device-Specific
            }

            Method (_NTT, 0, NotSerialized)  // _NTT: Notification Temperature Threshold
            {
                Return (0x0ADE)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (\SSP5) /* External reference */
            }

            Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S5PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S5PT)
                }
                Else
                {
                    If ((\S5AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Local1 = \_SB.IETM.CTOK (\S5AT)
                }

                If ((LSTM >= Local1))
                {
                    Return ((Local1 - 0x14))
                }
                Else
                {
                    Return (Local1)
                }
            }

            Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC0 () - 0x64))
            }

            Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CTYP)
                {
                    If ((\S2PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }
                }
                ElseIf ((\S2AT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return ((_AC1 () - 0x64))
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If (CTYP)
                {
                    If ((\S5AT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S5AT))
                }
                Else
                {
                    If ((\S5PT == Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    Return (\_SB.IETM.CTOK (\S5PT))
                }
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If ((\S5CT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S5CT))
            }

            Method (_CR3, 0, Serialized)  // _CR3: Warm/Standby Temperature
            {
                If ((\S5S3 == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S5S3))
            }

            Method (_HOT, 0, Serialized)  // _HOT: Hot Temperature
            {
                If ((\S5HT == Zero))
                {
                    Return (0xFFFFFFFF)
                }

                Return (\_SB.IETM.CTOK (\S5HT))
            }
        }
    }

    Scope (\_SB.IETM)
    {
        Name (PTTL, 0x14)
        Name (PSVT, Package (0x02)
        {
            0x02, 
            Package (0x0C)
            {
                \_SB.PCI0.B0D4, 
                \_SB.PCI0.LPCB.EC0.SEN2, 
                0x02, 
                0x012C, 
                0x0D36, 
                0x09, 
                0x00010000, 
                "MAX", 
                0x01F4, 
                0x0A, 
                0x14, 
                Zero
            }
        })
    }

    Scope (\_SB.IETM)
    {
        Name (DP2P, Package (0x01)
        {
            ToUUID ("9e04115a-ae87-4d1c-9500-0f3e340bfe75")
        })
        Name (DPSP, Package (0x01)
        {
            ToUUID ("42a441d6-ae6a-462b-a84b-4a8ce79027d3")
        })
        Name (DASP, Package (0x01)
        {
            ToUUID ("3a95c389-e4b8-4629-a526-c52c88626bae")
        })
        Name (DA2P, Package (0x01)
        {
            ToUUID ("0e56fab6-bdfc-4e8c-8246-40ecfd4d74ea")
        })
        Name (DCSP, Package (0x01)
        {
            ToUUID ("97c68ae7-15fa-499c-b8c9-5da81d606e0a")
        })
        Name (RFIP, Package (0x01)
        {
            ToUUID ("c4ce1849-243a-49f3-b8d5-f97002f38e6a")
        })
        Name (POBP, Package (0x01)
        {
            ToUUID ("f5a35014-c209-46a4-993a-eb56de7530a1")
        })
        Name (DAPP, Package (0x01)
        {
            ToUUID ("63be270f-1c11-48fd-a6f7-3af253ff3e2d")
        })
        Name (DVSP, Package (0x01)
        {
            ToUUID ("6ed722a7-9240-48a5-b479-31eef723d7cf")
        })
        Name (DPID, Package (0x01)
        {
            ToUUID ("42496e14-bc1b-46e8-a798-ca915464426f")
        })
    }

    Scope (\_SB.IETM)
    {
        Method (TEVT, 2, Serialized)
        {
            Switch (Arg0)
            {
                Case ("IETM")
                {
                    Notify (\_SB.IETM, Arg1)
                }
                Case ("B0D4")
                {
                    Notify (\_SB.PCI0.B0D4, Arg1)
                }
                Case ("SEN2")
                {
                    Notify (\_SB.PCI0.LPCB.EC0.SEN2, Arg1)
                }
                Case ("SEN3")
                {
                    Notify (\_SB.PCI0.LPCB.EC0.SEN3, Arg1)
                }
                Case ("SEN4")
                {
                    Notify (\_SB.PCI0.LPCB.EC0.SEN4, Arg1)
                }
                Case ("SEN5")
                {
                    Notify (\_SB.PCI0.LPCB.EC0.SEN5, Arg1)
                }

            }
        }
    }

    Scope (\_SB.IETM)
    {
        Method (GDDV, 0, Serialized)
        {
            Return (Package (0x01)
            {
                Buffer (0x0623)
                {
                    /* 0000 */  0xE5, 0x1F, 0x94, 0x00, 0x00, 0x00, 0x00, 0x02,  // ........
                    /* 0008 */  0x00, 0x00, 0x00, 0x40, 0x67, 0x64, 0x64, 0x76,  // ...@gddv
                    /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0020 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x4F, 0x45, 0x4D, 0x20,  // ....OEM 
                    /* 0030 */  0x45, 0x78, 0x70, 0x6F, 0x72, 0x74, 0x65, 0x64,  // Exported
                    /* 0038 */  0x20, 0x44, 0x61, 0x74, 0x61, 0x56, 0x61, 0x75,  //  DataVau
                    /* 0040 */  0x6C, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // lt......
                    /* 0048 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0058 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0060 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0068 */  0x00, 0x00, 0x00, 0x00, 0x8D, 0x0F, 0x5C, 0x7E,  // ......\~
                    /* 0070 */  0xE1, 0x7F, 0x40, 0xEB, 0x80, 0x0F, 0x81, 0xF4,  // ..@.....
                    /* 0078 */  0x66, 0x70, 0x08, 0xCD, 0x73, 0xB3, 0xF6, 0xDB,  // fp..s...
                    /* 0080 */  0xE8, 0x24, 0x6A, 0x48, 0x22, 0x4A, 0x14, 0x00,  // .$jH"J..
                    /* 0088 */  0x86, 0x63, 0x1B, 0x75, 0x8F, 0x05, 0x00, 0x00,  // .c.u....
                    /* 0090 */  0x52, 0x45, 0x50, 0x4F, 0x5D, 0x00, 0x00, 0x00,  // REPO]...
                    /* 0098 */  0x01, 0xAD, 0x98, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 00A0 */  0x00, 0x00, 0x72, 0x87, 0xCD, 0xFF, 0x6D, 0x24,  // ..r...m$
                    /* 00A8 */  0x47, 0xDB, 0x3D, 0x24, 0x92, 0xB4, 0x16, 0x6F,  // G.=$...o
                    /* 00B0 */  0x45, 0xD8, 0xC3, 0xF5, 0x66, 0x14, 0x9F, 0x22,  // E...f.."
                    /* 00B8 */  0xD7, 0xF7, 0xDE, 0x67, 0x90, 0x9A, 0xA2, 0x0D,  // ...g....
                    /* 00C0 */  0x39, 0x25, 0xAD, 0xC3, 0x1A, 0xAD, 0x52, 0x0B,  // 9%....R.
                    /* 00C8 */  0x75, 0x38, 0xE1, 0xA4, 0x14, 0x43, 0x20, 0x3B,  // u8...C ;
                    /* 00D0 */  0x8E, 0xDD, 0xD0, 0x21, 0x74, 0xD0, 0xD1, 0x9C,  // ...!t...
                    /* 00D8 */  0x85, 0x29, 0x5B, 0x8A, 0xD2, 0xE7, 0xE2, 0xE8,  // .)[.....
                    /* 00E0 */  0x66, 0x8F, 0xAB, 0xF6, 0x2F, 0xB9, 0x22, 0x5B,  // f.../."[
                    /* 00E8 */  0x59, 0xFE, 0xB7, 0xD5, 0x21, 0x5B, 0x81, 0xAE,  // Y...![..
                    /* 00F0 */  0xDC, 0xDD, 0xCE, 0x69, 0xDE, 0x09, 0xEF, 0xCE,  // ...i....
                    /* 00F8 */  0xB8, 0x59, 0x97, 0x20, 0xBC, 0x8B, 0x36, 0x30,  // .Y. ..60
                    /* 0100 */  0xA5, 0x43, 0x94, 0x97, 0x85, 0x63, 0xD1, 0x78,  // .C...c.x
                    /* 0108 */  0x92, 0x28, 0xBE, 0xE4, 0x9C, 0x49, 0xEF, 0x3C,  // .(...I.<
                    /* 0110 */  0x50, 0x9D, 0x8F, 0xDA, 0x7B, 0x8A, 0x38, 0x64,  // P...{.8d
                    /* 0118 */  0xE5, 0xEC, 0xD1, 0x57, 0x3F, 0xDF, 0x91, 0x27,  // ...W?..'
                    /* 0120 */  0x55, 0x07, 0x37, 0x9C, 0x39, 0x76, 0x89, 0x48,  // U.7.9v.H
                    /* 0128 */  0x92, 0xEB, 0x96, 0x84, 0xAA, 0xED, 0xFD, 0xCB,  // ........
                    /* 0130 */  0x86, 0x60, 0xC8, 0x40, 0x63, 0x70, 0xFB, 0xE4,  // .`.@cp..
                    /* 0138 */  0x66, 0xB5, 0x3B, 0x45, 0x70, 0xC1, 0xF2, 0x1B,  // f.;Ep...
                    /* 0140 */  0x2C, 0x27, 0x60, 0x5F, 0xCC, 0x83, 0x5D, 0x29,  // ,'`_..])
                    /* 0148 */  0xDE, 0xA7, 0xDE, 0x97, 0x04, 0x83, 0x3A, 0xF5,  // ......:.
                    /* 0150 */  0x79, 0xAA, 0x9B, 0x9D, 0x87, 0x86, 0xE3, 0x0C,  // y.......
                    /* 0158 */  0x9E, 0xDC, 0x4E, 0xF3, 0xFF, 0x66, 0x8B, 0xB1,  // ..N..f..
                    /* 0160 */  0x7F, 0xE1, 0x19, 0x19, 0x07, 0x6B, 0x19, 0x6D,  // .....k.m
                    /* 0168 */  0xAD, 0x18, 0x47, 0x73, 0x20, 0xC6, 0xE6, 0x3D,  // ..Gs ..=
                    /* 0170 */  0x5D, 0x93, 0x65, 0x62, 0xA4, 0x60, 0x28, 0x78,  // ].eb.`(x
                    /* 0178 */  0x56, 0x07, 0x65, 0x24, 0xF0, 0xAB, 0x48, 0x18,  // V.e$..H.
                    /* 0180 */  0x5D, 0x4E, 0x1B, 0x6B, 0x67, 0x51, 0x9B, 0xD2,  // ]N.kgQ..
                    /* 0188 */  0xDC, 0x8D, 0xA4, 0x6A, 0xB6, 0xFC, 0x50, 0xA9,  // ...j..P.
                    /* 0190 */  0xA4, 0x00, 0x5B, 0xA1, 0xEE, 0x70, 0xFF, 0x7C,  // ..[..p.|
                    /* 0198 */  0x61, 0x94, 0xD0, 0x41, 0xFD, 0xB5, 0x08, 0x1F,  // a..A....
                    /* 01A0 */  0x12, 0xCF, 0x3E, 0xD1, 0xB1, 0x47, 0xE9, 0x98,  // ..>..G..
                    /* 01A8 */  0xFB, 0x89, 0x4A, 0x7E, 0x3B, 0x04, 0x4D, 0xB5,  // ..J~;.M.
                    /* 01B0 */  0x0F, 0x85, 0x85, 0x4F, 0xDD, 0xF7, 0x13, 0xF3,  // ...O....
                    /* 01B8 */  0x38, 0x7B, 0x82, 0xC7, 0x98, 0x90, 0x01, 0x86,  // 8{......
                    /* 01C0 */  0xDB, 0xCA, 0xAD, 0x4D, 0xC8, 0x20, 0x6F, 0x82,  // ...M. o.
                    /* 01C8 */  0x9F, 0x19, 0xEB, 0xA8, 0xAB, 0xD1, 0x71, 0x74,  // ......qt
                    /* 01D0 */  0x9F, 0xF8, 0x68, 0x8A, 0x98, 0x53, 0x10, 0x94,  // ..h..S..
                    /* 01D8 */  0xC2, 0x65, 0xAA, 0xF9, 0x47, 0x9F, 0x5D, 0x3B,  // .e..G.];
                    /* 01E0 */  0x4E, 0x6A, 0x30, 0xC7, 0xE8, 0xBC, 0x67, 0x2C,  // Nj0...g,
                    /* 01E8 */  0x92, 0x11, 0xAF, 0x86, 0x2F, 0xA1, 0x9C, 0xD4,  // ..../...
                    /* 01F0 */  0x8B, 0x04, 0x8E, 0x9C, 0xB3, 0x37, 0x5B, 0x7B,  // .....7[{
                    /* 01F8 */  0xB0, 0x61, 0xAE, 0x75, 0xED, 0x17, 0xE4, 0x90,  // .a.u....
                    /* 0200 */  0xE0, 0x15, 0xEF, 0x37, 0xD9, 0x9A, 0x26, 0x71,  // ...7..&q
                    /* 0208 */  0xAF, 0xF5, 0x5A, 0x0A, 0xE4, 0xF8, 0xF9, 0x49,  // ..Z....I
                    /* 0210 */  0x58, 0xA0, 0xFD, 0x48, 0x6C, 0x06, 0x02, 0x39,  // X..Hl..9
                    /* 0218 */  0x8C, 0x93, 0xC4, 0x58, 0x00, 0xB9, 0x4E, 0x50,  // ...X..NP
                    /* 0220 */  0x04, 0xDE, 0x73, 0xB1, 0x6C, 0x07, 0x71, 0x8C,  // ..s.l.q.
                    /* 0228 */  0x0E, 0xA5, 0xA7, 0xA2, 0xB4, 0x3C, 0x0B, 0x2F,  // .....<./
                    /* 0230 */  0xA9, 0xD6, 0xB1, 0x30, 0x22, 0x20, 0xC0, 0xF5,  // ...0" ..
                    /* 0238 */  0x3E, 0x23, 0x22, 0x59, 0x7E, 0x59, 0x3B, 0xC9,  // >#"Y~Y;.
                    /* 0240 */  0x98, 0xF6, 0x45, 0x90, 0x31, 0xB6, 0x07, 0x47,  // ..E.1..G
                    /* 0248 */  0x5B, 0x46, 0x89, 0x20, 0x31, 0xC8, 0x57, 0x35,  // [F. 1.W5
                    /* 0250 */  0x5F, 0xE1, 0xC7, 0x45, 0x30, 0xCF, 0xBB, 0xD8,  // _..E0...
                    /* 0258 */  0xC6, 0x08, 0x35, 0x24, 0x1B, 0xDF, 0x09, 0x70,  // ..5$...p
                    /* 0260 */  0xEC, 0x96, 0x39, 0x75, 0x72, 0x31, 0xB9, 0x6B,  // ..9ur1.k
                    /* 0268 */  0xB2, 0x1D, 0x03, 0xDC, 0x74, 0x55, 0x59, 0xE0,  // ....tUY.
                    /* 0270 */  0xBE, 0x1F, 0xF8, 0xCC, 0x49, 0x2C, 0x98, 0x39,  // ....I,.9
                    /* 0278 */  0x91, 0xE3, 0x16, 0x91, 0x48, 0xF7, 0x2E, 0xCF,  // ....H...
                    /* 0280 */  0x04, 0x57, 0x1F, 0xDC, 0x11, 0x92, 0x60, 0x18,  // .W....`.
                    /* 0288 */  0x2E, 0x07, 0x81, 0x9B, 0x95, 0xC3, 0x97, 0x2C,  // .......,
                    /* 0290 */  0xE0, 0xB6, 0xA8, 0x81, 0xCF, 0x31, 0x89, 0x70,  // .....1.p
                    /* 0298 */  0x47, 0x2D, 0x07, 0x1D, 0xC3, 0x50, 0x71, 0xCA,  // G-...Pq.
                    /* 02A0 */  0x26, 0xEA, 0xB3, 0xE7, 0x6D, 0x1D, 0xF0, 0x83,  // &...m...
                    /* 02A8 */  0x2A, 0x9A, 0x77, 0x96, 0xE4, 0x02, 0x06, 0x35,  // *.w....5
                    /* 02B0 */  0xE8, 0x70, 0x57, 0x4D, 0x82, 0xA7, 0x01, 0x80,  // .pWM....
                    /* 02B8 */  0x9B, 0x87, 0xC3, 0xAD, 0x4A, 0x12, 0x71, 0x3C,  // ....J.q<
                    /* 02C0 */  0x55, 0xD5, 0x17, 0x85, 0x5A, 0x6C, 0xB7, 0x70,  // U...Zl.p
                    /* 02C8 */  0x18, 0xB2, 0x84, 0xA7, 0xD8, 0xDE, 0x0E, 0xAB,  // ........
                    /* 02D0 */  0x14, 0x38, 0xF7, 0x8B, 0xD4, 0xA0, 0x85, 0xC3,  // .8......
                    /* 02D8 */  0xB5, 0x6C, 0x1F, 0x3C, 0x62, 0x33, 0x18, 0x2F,  // .l.<b3./
                    /* 02E0 */  0xC9, 0x94, 0x4D, 0x94, 0xCA, 0x44, 0x28, 0x11,  // ..M..D(.
                    /* 02E8 */  0x30, 0x22, 0xDE, 0x7B, 0x98, 0x8D, 0x50, 0xBB,  // 0".{..P.
                    /* 02F0 */  0x83, 0xE7, 0x00, 0x35, 0xDF, 0xE2, 0x3E, 0x9E,  // ...5..>.
                    /* 02F8 */  0x76, 0x74, 0xB8, 0x17, 0xBD, 0x28, 0xF6, 0x8B,  // vt...(..
                    /* 0300 */  0x8F, 0xC8, 0x2D, 0xBE, 0x4C, 0x8A, 0x8A, 0xF6,  // ..-.L...
                    /* 0308 */  0x4E, 0x36, 0x60, 0xA1, 0xEE, 0x4D, 0xF3, 0x96,  // N6`..M..
                    /* 0310 */  0xB4, 0xFA, 0x62, 0x48, 0x69, 0xFC, 0x37, 0x9C,  // ..bHi.7.
                    /* 0318 */  0xFA, 0xDF, 0xDE, 0x17, 0xB4, 0xC3, 0x35, 0x61,  // ......5a
                    /* 0320 */  0xDA, 0xD6, 0x37, 0x66, 0x22, 0xD8, 0x18, 0x17,  // ..7f"...
                    /* 0328 */  0x4E, 0x11, 0x92, 0x40, 0x98, 0x67, 0x7C, 0x92,  // N..@.g|.
                    /* 0330 */  0xF5, 0x06, 0x6E, 0x34, 0x9B, 0x5F, 0xA7, 0xCD,  // ..n4._..
                    /* 0338 */  0xDD, 0x7E, 0x8F, 0x4E, 0x79, 0xA3, 0x20, 0xB8,  // .~.Ny. .
                    /* 0340 */  0x23, 0xFF, 0x6E, 0x85, 0x89, 0xF2, 0x03, 0x56,  // #.n....V
                    /* 0348 */  0xDA, 0x93, 0xDA, 0xE4, 0xC0, 0x22, 0x1E, 0x21,  // .....".!
                    /* 0350 */  0xDF, 0xA3, 0xDE, 0xCB, 0x3C, 0x01, 0xA0, 0x56,  // ....<..V
                    /* 0358 */  0xE8, 0x25, 0xFE, 0x1A, 0x73, 0x1C, 0x36, 0x0D,  // .%..s.6.
                    /* 0360 */  0x23, 0xD8, 0xD5, 0xF1, 0xA8, 0x18, 0x34, 0x4B,  // #.....4K
                    /* 0368 */  0x66, 0x70, 0x6B, 0x5D, 0x43, 0x91, 0xE2, 0x72,  // fpk]C..r
                    /* 0370 */  0x09, 0xDF, 0x8B, 0x95, 0xDF, 0x1F, 0x1A, 0x54,  // .......T
                    /* 0378 */  0xB9, 0x09, 0xEF, 0x89, 0x21, 0xDC, 0x73, 0xBA,  // ....!.s.
                    /* 0380 */  0x8B, 0x96, 0x1A, 0x89, 0x44, 0x34, 0x77, 0xE2,  // ....D4w.
                    /* 0388 */  0xDF, 0xC6, 0xDC, 0x6D, 0xD2, 0x30, 0xA4, 0xFB,  // ...m.0..
                    /* 0390 */  0x11, 0xF5, 0x05, 0x42, 0x8E, 0x74, 0x20, 0x9C,  // ...B.t .
                    /* 0398 */  0x79, 0xB2, 0x7B, 0x63, 0xCD, 0xCD, 0x7F, 0xBA,  // y.{c....
                    /* 03A0 */  0xDF, 0x53, 0xA2, 0x57, 0x52, 0xAB, 0x2A, 0xE6,  // .S.WR.*.
                    /* 03A8 */  0xD8, 0xCD, 0x47, 0x3B, 0x1A, 0x22, 0x4F, 0x59,  // ..G;."OY
                    /* 03B0 */  0x1B, 0xBE, 0xB0, 0xC5, 0xE5, 0xB3, 0x7C, 0x52,  // ......|R
                    /* 03B8 */  0x2E, 0x88, 0x13, 0x32, 0x08, 0x57, 0xD3, 0xF1,  // ...2.W..
                    /* 03C0 */  0x5F, 0xF7, 0x20, 0x91, 0xBA, 0xA4, 0xF7, 0xBD,  // _. .....
                    /* 03C8 */  0x0D, 0x0A, 0x6C, 0x2D, 0x80, 0xB8, 0x94, 0xE1,  // ..l-....
                    /* 03D0 */  0x4C, 0x7B, 0x02, 0x71, 0xB2, 0x90, 0x32, 0xDF,  // L{.q..2.
                    /* 03D8 */  0xF7, 0xC2, 0x1C, 0x7F, 0x77, 0xF7, 0xC0, 0x7A,  // ....w..z
                    /* 03E0 */  0xD9, 0x12, 0x20, 0xE8, 0xE3, 0x02, 0xAF, 0x9F,  // .. .....
                    /* 03E8 */  0x4E, 0x4D, 0x7F, 0xAE, 0xA6, 0x03, 0xFF, 0x0C,  // NM......
                    /* 03F0 */  0x79, 0x80, 0x0E, 0x76, 0x5B, 0x69, 0x59, 0x3A,  // y..v[iY:
                    /* 03F8 */  0x32, 0x12, 0xF2, 0x3E, 0x7B, 0x9A, 0x4D, 0x19,  // 2..>{.M.
                    /* 0400 */  0xCF, 0x7C, 0x24, 0x1E, 0x8F, 0x18, 0xAA, 0xA5,  // .|$.....
                    /* 0408 */  0x75, 0x4B, 0x40, 0xE4, 0x27, 0x26, 0xB1, 0x2C,  // uK@.'&.,
                    /* 0410 */  0x7A, 0x32, 0x34, 0xF0, 0xD4, 0xA5, 0x39, 0x0D,  // z24...9.
                    /* 0418 */  0xA8, 0x98, 0x35, 0x09, 0x07, 0xFD, 0x9C, 0xBD,  // ..5.....
                    /* 0420 */  0x42, 0x69, 0x1C, 0xEC, 0x52, 0x21, 0x58, 0xC1,  // Bi..R!X.
                    /* 0428 */  0xF7, 0xE1, 0x9F, 0x8E, 0x16, 0x0D, 0x66, 0x07,  // ......f.
                    /* 0430 */  0x0B, 0x08, 0x5E, 0x30, 0x93, 0xD6, 0x4E, 0x1A,  // ..^0..N.
                    /* 0438 */  0x0E, 0x6A, 0x44, 0x61, 0xD9, 0xD3, 0xCB, 0x5B,  // .jDa...[
                    /* 0440 */  0xE9, 0xC8, 0x59, 0x21, 0x15, 0x19, 0x7D, 0xF3,  // ..Y!..}.
                    /* 0448 */  0x04, 0xBF, 0x99, 0xCF, 0xE5, 0x21, 0xAB, 0xE4,  // .....!..
                    /* 0450 */  0x40, 0xAE, 0x6B, 0x70, 0x99, 0x7A, 0x56, 0x1B,  // @.kp.zV.
                    /* 0458 */  0x07, 0x83, 0x57, 0x30, 0xC1, 0x91, 0x06, 0xE1,  // ..W0....
                    /* 0460 */  0xFD, 0x11, 0x96, 0xF8, 0x71, 0x3E, 0xAB, 0x08,  // ....q>..
                    /* 0468 */  0x2A, 0xF0, 0xAC, 0x38, 0xC7, 0xF0, 0xFC, 0x5F,  // *..8..._
                    /* 0470 */  0xAD, 0x5D, 0xAE, 0xBE, 0x24, 0xDE, 0x6D, 0x3F,  // .]..$.m?
                    /* 0478 */  0x32, 0x21, 0xBD, 0x68, 0x93, 0x01, 0xA1, 0x61,  // 2!.h...a
                    /* 0480 */  0x27, 0xFE, 0xE8, 0x91, 0x03, 0x00, 0x88, 0x0B,  // '.......
                    /* 0488 */  0x19, 0x03, 0x1B, 0x7D, 0xF1, 0x30, 0x8B, 0x1E,  // ...}.0..
                    /* 0490 */  0x5E, 0x52, 0xB1, 0x13, 0x73, 0xCE, 0x58, 0x9D,  // ^R..s.X.
                    /* 0498 */  0x63, 0xF3, 0x48, 0xC4, 0xE5, 0xB4, 0x4D, 0x4C,  // c.H...ML
                    /* 04A0 */  0x85, 0x7D, 0x41, 0xE9, 0x7D, 0xEB, 0xE1, 0xDB,  // .}A.}...
                    /* 04A8 */  0x1C, 0xB8, 0xB3, 0xB9, 0xD9, 0xDB, 0xF5, 0xD0,  // ........
                    /* 04B0 */  0x45, 0xC2, 0x26, 0xBA, 0xCB, 0x0A, 0xD5, 0x66,  // E.&....f
                    /* 04B8 */  0xEA, 0x30, 0x9A, 0x79, 0x9F, 0x97, 0xFE, 0x69,  // .0.y...i
                    /* 04C0 */  0xDD, 0x86, 0x82, 0x48, 0xDE, 0x5F, 0xE9, 0xF9,  // ...H._..
                    /* 04C8 */  0x7F, 0xB1, 0xF0, 0x83, 0xBE, 0xE9, 0xD6, 0x3D,  // .......=
                    /* 04D0 */  0x27, 0x57, 0x0B, 0xF3, 0xFD, 0x62, 0xDD, 0xD0,  // 'W...b..
                    /* 04D8 */  0x5E, 0x3A, 0x6F, 0x37, 0xBB, 0xDF, 0xD0, 0x37,  // ^:o7...7
                    /* 04E0 */  0x27, 0xEE, 0xBC, 0x0F, 0x0A, 0xE3, 0xC2, 0x07,  // '.......
                    /* 04E8 */  0xDD, 0x94, 0xE1, 0xEE, 0x7D, 0xFA, 0x1B, 0x68,  // ....}..h
                    /* 04F0 */  0xBE, 0xD6, 0x49, 0x44, 0x98, 0x09, 0x5F, 0x8D,  // ..ID.._.
                    /* 04F8 */  0x30, 0x3E, 0xE2, 0xC8, 0x9D, 0xFD, 0xE3, 0x49,  // 0>.....I
                    /* 0500 */  0x1F, 0x5F, 0xE7, 0x2F, 0x08, 0x72, 0xF2, 0xDB,  // ._./.r..
                    /* 0508 */  0x28, 0x31, 0xEE, 0xA4, 0xAE, 0xD5, 0x92, 0xBC,  // (1......
                    /* 0510 */  0x40, 0xDF, 0x32, 0xB9, 0xCA, 0x38, 0xC8, 0x2D,  // @.2..8.-
                    /* 0518 */  0xA3, 0xC5, 0x0F, 0x8D, 0xAF, 0xBF, 0xFC, 0xB7,  // ........
                    /* 0520 */  0x7C, 0x48, 0x75, 0x90, 0xBE, 0x19, 0x0C, 0xBA,  // |Hu.....
                    /* 0528 */  0x3C, 0x88, 0x3F, 0xFC, 0x30, 0xFB, 0x0A, 0xD6,  // <.?.0...
                    /* 0530 */  0x76, 0xF6, 0x3B, 0x87, 0x24, 0xC9, 0x56, 0x12,  // v.;.$.V.
                    /* 0538 */  0x00, 0x93, 0x0B, 0x66, 0x14, 0xDD, 0x6B, 0x3F,  // ...f..k?
                    /* 0540 */  0xF8, 0x93, 0x70, 0x3F, 0xC7, 0x0E, 0xAE, 0x1C,  // ..p?....
                    /* 0548 */  0xCB, 0x55, 0x59, 0xD6, 0x38, 0xE5, 0x36, 0xD1,  // .UY.8.6.
                    /* 0550 */  0x72, 0x1F, 0xBC, 0x76, 0xE7, 0xF3, 0x2D, 0xBB,  // r..v..-.
                    /* 0558 */  0xBB, 0x23, 0x3D, 0x3A, 0x2A, 0xDD, 0x15, 0x2A,  // .#=:*..*
                    /* 0560 */  0xCE, 0x43, 0xA1, 0xB0, 0xBF, 0x86, 0x93, 0xE1,  // .C......
                    /* 0568 */  0xA3, 0x85, 0x13, 0xB6, 0x8F, 0x1E, 0xDF, 0xF4,  // ........
                    /* 0570 */  0xB1, 0x33, 0x63, 0x99, 0x15, 0xDF, 0x16, 0xF3,  // .3c.....
                    /* 0578 */  0x3A, 0x4F, 0x7A, 0x99, 0x72, 0xBA, 0xED, 0x1F,  // :Oz.r...
                    /* 0580 */  0x99, 0x44, 0xD9, 0x99, 0xC2, 0x7B, 0xD2, 0xEF,  // .D...{..
                    /* 0588 */  0x22, 0x96, 0x82, 0x99, 0x68, 0x9F, 0x94, 0xB7,  // "...h...
                    /* 0590 */  0xCA, 0x43, 0x46, 0x0C, 0x34, 0x2D, 0x9B, 0x1C,  // .CF.4-..
                    /* 0598 */  0x83, 0x99, 0x50, 0x2E, 0x13, 0x14, 0x55, 0x8A,  // ..P...U.
                    /* 05A0 */  0x68, 0xC6, 0x25, 0x2A, 0x94, 0xE5, 0x0C, 0xEB,  // h.%*....
                    /* 05A8 */  0xC1, 0x32, 0x98, 0x6F, 0xD6, 0x62, 0x56, 0x26,  // .2.o.bV&
                    /* 05B0 */  0xC2, 0x4E, 0x15, 0x41, 0xFF, 0xC9, 0xC0, 0x64,  // .N.A...d
                    /* 05B8 */  0x0B, 0x7F, 0x66, 0x38, 0x02, 0x78, 0x31, 0x96,  // ..f8.x1.
                    /* 05C0 */  0x54, 0x0F, 0xD2, 0xC0, 0x7E, 0x1D, 0xEA, 0xCB,  // T...~...
                    /* 05C8 */  0x4E, 0x9E, 0x65, 0x37, 0x3E, 0x24, 0x13, 0x94,  // N.e7>$..
                    /* 05D0 */  0xCF, 0xE4, 0xDF, 0x27, 0x20, 0xE3, 0x32, 0x3B,  // ...' .2;
                    /* 05D8 */  0x78, 0xB7, 0x67, 0x26, 0xB3, 0x89, 0x1B, 0xDC,  // x.g&....
                    /* 05E0 */  0x44, 0xA5, 0x69, 0x49, 0x92, 0x1D, 0x64, 0x62,  // D.iI..db
                    /* 05E8 */  0xD3, 0xA3, 0x88, 0xB0, 0xFE, 0x80, 0xA6, 0x87,  // ........
                    /* 05F0 */  0x13, 0x04, 0x5F, 0x17, 0xB1, 0xE6, 0xE3, 0x4E,  // .._....N
                    /* 05F8 */  0x2B, 0xFE, 0x93, 0x71, 0x0E, 0xFA, 0xA2, 0xD1,  // +..q....
                    /* 0600 */  0x8C, 0x69, 0x0C, 0xB9, 0xE3, 0x43, 0x34, 0x0F,  // .i...C4.
                    /* 0608 */  0xA7, 0x54, 0xAB, 0xE0, 0x61, 0xC4, 0xFE, 0x2E,  // .T..a...
                    /* 0610 */  0x30, 0x9A, 0xA4, 0xDD, 0xE4, 0x95, 0xB5, 0x6E,  // 0......n
                    /* 0618 */  0x9C, 0xE4, 0x3E, 0xF2, 0xE8, 0x5D, 0x70, 0x71,  // ..>..]pq
                    /* 0620 */  0xF5, 0x57, 0x00                                 // .W.
                }
            })
        }

        Method (IMOK, 1, NotSerialized)
        {
            ADBG ("IMOK")
            ADBG (Arg0)
            Return (Arg0)
        }
    }
}

