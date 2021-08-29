/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-12-DscAtiBD.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000015F9 (5625)
 *     Revision         0x01
 *     Checksum         0xFC
 *     OEM ID           "OemAti"
 *     OEM Table ID     "DscAtiBD"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 1, "OemAti", "DscAtiBD", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.ASPM, UnknownObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.GFX0.AINT, MethodObj)    // 2 Arguments
    External (_SB_.PCI0.GFX0.IDAB, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.ACPL, UnknownObj)
    External (_SB_.PCI0.LPCB.EC0_.ADPT, UnknownObj)
    External (_SB_.PCI0.LPCB.EC0_.DCPL, UnknownObj)
    External (_SB_.PCI0.LPCB.EC0_.VGAD, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.LSTE, UnknownObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.P2PD.DGPU, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.P2PD.DGPU._ADR, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.P2PD.DGPU.DD02, UnknownObj)
    External (_SB_.PCI0.PGOF, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.PGON, MethodObj)    // 1 Arguments
    External (AMDA, UnknownObj)
    External (DSEN, UnknownObj)
    External (EBAS, UnknownObj)
    External (ECON, IntObj)
    External (EGBN, UnknownObj)
    External (GPRW, MethodObj)    // 2 Arguments
    External (HYSS, UnknownObj)
    External (MXD1, UnknownObj)    // Conflicts with a later declaration
    External (MXD2, UnknownObj)    // Conflicts with a later declaration
    External (MXD3, UnknownObj)    // Conflicts with a later declaration
    External (MXD4, UnknownObj)    // Conflicts with a later declaration
    External (MXD5, UnknownObj)    // Conflicts with a later declaration
    External (MXD6, UnknownObj)    // Conflicts with a later declaration
    External (MXD7, UnknownObj)    // Conflicts with a later declaration
    External (MXD8, UnknownObj)    // Conflicts with a later declaration
    External (NVAF, UnknownObj)
    External (NXD1, UnknownObj)
    External (NXD2, UnknownObj)
    External (NXD3, UnknownObj)
    External (NXD4, UnknownObj)
    External (NXD5, UnknownObj)
    External (NXD6, UnknownObj)
    External (NXD7, UnknownObj)
    External (NXD8, UnknownObj)
    External (OSYS, UnknownObj)
    External (SGFL, UnknownObj)
    External (SGMD, UnknownObj)
    External (XBAS, UnknownObj)

    OperationRegion (TPNV, SystemMemory, 0x81E8E000, 0x0036)
    Field (TPNV, AnyAcc, Lock, Preserve)
    {
        MXD1,   32, 
        MXD2,   32, 
        MXD3,   32, 
        MXD4,   32, 
        MXD5,   32, 
        MXD6,   32, 
        MXD7,   32, 
        MXD8,   32, 
        EBAS,   32, 
        DGVS,   32, 
        DGVB,   32, 
        HYSS,   32, 
        NVAF,   8, 
        DEID,   16, 
        DPMF,   8, 
        SDMF,   8, 
        CHPV,   8
    }

    Scope (\_SB.PCI0.PEG0)
    {
        OperationRegion (MSID, SystemMemory, EBAS, 0x0500)
        Field (MSID, DWordAcc, Lock, Preserve)
        {
            VEID,   16, 
            Offset (0x40), 
            NVID,   32, 
            Offset (0x4C), 
            ATID,   32, 
            Offset (0x48B), 
                ,   1, 
            NHDA,   1
        }

        OperationRegion (RPCX, SystemMemory, ((\XBAS + 0x8000) + Zero), 0x1000)
        Field (RPCX, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            CMDR,   8, 
            Offset (0x19), 
            PRBN,   8, 
            Offset (0x84), 
            D0ST,   2, 
            Offset (0xAA), 
            CEDR,   1, 
            Offset (0xB0), 
            ASPM,   2, 
                ,   2, 
            LNKD,   1, 
            Offset (0xC9), 
                ,   2, 
            LREN,   1, 
            Offset (0x216), 
            LNKS,   4
        }

        PowerResource (PG00, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                If ((OSYS > 0x07D9))
                {
                    PGON (Zero)
                    CMDR |= 0x07
                    D0ST = Zero
                    If ((VEID == 0x10DE))
                    {
                        NVID = HYSS /* \HYSS */
                    }

                    If ((VEID == 0x1002)){}
                    _STA = One
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                If ((OSYS > 0x07D9))
                {
                    PGOF (Zero)
                    _STA = Zero
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PG00
        })
        Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
        {
            PG00
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PG00
        })
    }

    Scope (\_SB.PCI0.PEG0.PEGP)
    {
        Device (P2PD)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Device (DGPU)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }
        }
    }

    Scope (\_SB.PCI0.PEG0.PEGP)
    {
        OperationRegion (UBCS, PCI_Config, Zero, 0x0100)
        Field (UBCS, DWordAcc, NoLock, Preserve)
        {
            Offset (0x68), 
            ASPM,   2
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }
    }

    Scope (\_SB.PCI0.PEG0.PEGP.P2PD)
    {
        OperationRegion (DBCS, PCI_Config, Zero, 0x0100)
        Field (DBCS, DWordAcc, NoLock, Preserve)
        {
            Offset (0x68), 
            ASPM,   2
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            Return (GPRW (0x69, 0x04))
        }
    }

    Scope (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU)
    {
        OperationRegion (EDCS, PCI_Config, Zero, 0x0100)
        Field (EDCS, DWordAcc, NoLock, Preserve)
        {
            Offset (0x74), 
            ASPM,   2
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            Return (GPRW (0x69, 0x04))
        }
    }

    Scope (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU)
    {
        Method (_ON, 0, Serialized)  // _ON_: Power On
        {
            \_SB.PCI0.PGON (Zero)
            Notify (\_SB.PCI0.PEG0, Zero) // Bus Check
        }

        Method (_OFF, 0, Serialized)  // _OFF: Power Off
        {
            \_SB.PCI0.PGOF (Zero)
            Notify (\_SB.PCI0.PEG0, Zero) // Bus Check
        }

        Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
        {
            Return (Package (0x03)
            {
                0x0110, 
                0x0210, 
                0x0220
            })
        }

        Device (LCD0)
        {
            Method (_ADR, 0, Serialized)  // _ADR: Address
            {
                Return (0x0110)
            }

            Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
            {
                Return (Package (0x67)
                {
                    0x50, 
                    0x32, 
                    Zero, 
                    One, 
                    0x02, 
                    0x03, 
                    0x04, 
                    0x05, 
                    0x06, 
                    0x07, 
                    0x08, 
                    0x09, 
                    0x0A, 
                    0x0B, 
                    0x0C, 
                    0x0D, 
                    0x0E, 
                    0x0F, 
                    0x10, 
                    0x11, 
                    0x12, 
                    0x13, 
                    0x14, 
                    0x15, 
                    0x16, 
                    0x17, 
                    0x18, 
                    0x19, 
                    0x1A, 
                    0x1B, 
                    0x1C, 
                    0x1D, 
                    0x1E, 
                    0x1F, 
                    0x20, 
                    0x21, 
                    0x22, 
                    0x23, 
                    0x24, 
                    0x25, 
                    0x26, 
                    0x27, 
                    0x28, 
                    0x29, 
                    0x2A, 
                    0x2B, 
                    0x2C, 
                    0x2D, 
                    0x2E, 
                    0x2F, 
                    0x30, 
                    0x31, 
                    0x32, 
                    0x33, 
                    0x34, 
                    0x35, 
                    0x36, 
                    0x37, 
                    0x38, 
                    0x39, 
                    0x3A, 
                    0x3B, 
                    0x3C, 
                    0x3D, 
                    0x3E, 
                    0x3F, 
                    0x40, 
                    0x41, 
                    0x42, 
                    0x43, 
                    0x44, 
                    0x45, 
                    0x46, 
                    0x47, 
                    0x48, 
                    0x49, 
                    0x4A, 
                    0x4B, 
                    0x4C, 
                    0x4D, 
                    0x4E, 
                    0x4F, 
                    0x50, 
                    0x51, 
                    0x52, 
                    0x53, 
                    0x54, 
                    0x55, 
                    0x56, 
                    0x57, 
                    0x58, 
                    0x59, 
                    0x5A, 
                    0x5B, 
                    0x5C, 
                    0x5D, 
                    0x5E, 
                    0x5F, 
                    0x60, 
                    0x61, 
                    0x62, 
                    0x63, 
                    0x64
                })
            }
        }
    }

    Scope (\_SB.PCI0.GFX0)
    {
        OperationRegion (APXM, SystemMemory, AMDA, 0x00010400)
        Field (APXM, AnyAcc, NoLock, Preserve)
        {
            APSG,   128, 
            APSZ,   32, 
            APVR,   32, 
            APXA,   32, 
            RVBS,   32, 
            NTLE,   16, 
            TLE1,   16, 
            TLE2,   16, 
            TLE3,   16, 
            TLE4,   16, 
            TLE5,   16, 
            TLE6,   16, 
            TLE7,   16, 
            TLE8,   16, 
            TLE9,   16, 
            TL10,   16, 
            TL11,   16, 
            TL12,   16, 
            TL13,   16, 
            TL14,   16, 
            TL15,   16, 
            TGXA,   16, 
            AGXA,   16, 
            GSTP,   8, 
            DSWR,   8, 
            EMDR,   8, 
            PXGS,   8, 
            CACD,   16, 
            CCND,   16, 
            NACD,   16, 
            EXPM,   8, 
            TLSN,   16, 
            ELCL,   16, 
            RBF1,   262144, 
            RBF2,   262144
        }

        Method (ADPM, 2, Serialized)
        {
            Local1 = Zero
            Local0 = (Arg0 >> 0x10)
            If ((Arg1 == One))
            {
                Local1 |= (Local0 & One)
            }
            Else
            {
                Local1 |= ((Local0 & 0x02) >> One)
            }

            Local1 <<= One
            Local0 = (Arg0 >> 0x18)
            If ((Arg1 == One))
            {
                Local1 |= (Local0 & One)
            }
            Else
            {
                Local1 |= ((Local0 & 0x02) >> One)
            }

            Local1 <<= One
            Local0 = (Arg0 >> 0x08)
            If ((Arg1 == One))
            {
                Local1 |= (Local0 & One)
            }
            Else
            {
                Local1 |= ((Local0 & 0x02) >> One)
            }

            Return (Local1)
        }

        Method (ATPX, 2, Serialized)
        {
            If ((Arg0 == Zero))
            {
                Name (TMP1, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP1, Zero, F0SS)
                CreateWordField (TMP1, 0x02, F0IV)
                CreateDWordField (TMP1, 0x04, F0SF)
                F0SS = 0x08
                F0IV = One
                F0SF = 0xBF
                If ((SGMD == 0x02))
                {
                    F0SF = 0x33
                }

                F0SF = One
                Return (TMP1) /* \_SB_.PCI0.GFX0.ATPX.TMP1 */
            }

            If ((Arg0 == One))
            {
                Name (TMP2, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP2, Zero, F1SS)
                CreateDWordField (TMP2, 0x02, F1VM)
                CreateDWordField (TMP2, 0x06, F1FG)
                F1SS = 0x0A
                F1VM = 0x0003FFFF
                If ((SGMD == 0x02))
                {
                    F1FG = 0x4680
                    If ((OSYS < 0x07DD))
                    {
                        F1FG = 0x1E80
                    }
                }
                Else
                {
                    F1FG = 0x40
                }

                F1FG = 0x00031800
                Return (TMP2) /* \_SB_.PCI0.GFX0.ATPX.TMP2 */
            }

            If ((Arg0 == 0x02))
            {
                CreateWordField (Arg1, Zero, FN2S)
                CreateByteField (Arg1, 0x02, DGPR)
                If ((DGPR == Zero))
                {
                    \_SB.PCI0.PEG0.PEGP.P2PD.DGPU._OFF ()
                }

                If ((DGPR == One))
                {
                    \_SB.PCI0.PEG0.PEGP.P2PD.DGPU._ON ()
                }

                Return (Zero)
            }

            If ((Arg0 == 0x03))
            {
                CreateWordField (Arg1, Zero, FN3S)
                CreateWordField (Arg1, 0x02, SDMG)
                If ((SDMG == Zero)){}
                If ((SDMG == One)){}
                Return (Zero)
            }

            If ((Arg0 == 0x04))
            {
                CreateWordField (Arg1, Zero, FN4S)
                CreateWordField (Arg1, 0x02, SIMG)
                If ((SIMG == Zero)){}
                If ((SIMG == One)){}
                Return (Zero)
            }

            If ((Arg0 == 0x05))
            {
                CreateWordField (Arg1, Zero, FN5S)
                CreateWordField (Arg1, 0x02, TGFX)
                TGXA = TGFX /* \_SB_.PCI0.GFX0.ATPX.TGFX */
                GSTP = One
                Return (Zero)
            }

            If ((Arg0 == 0x06))
            {
                CreateWordField (Arg1, Zero, FN6S)
                CreateWordField (Arg1, 0x02, AGFX)
                AGXA = AGFX /* \_SB_.PCI0.GFX0.ATPX.AGFX */
                GSTP = Zero
                Return (Zero)
            }

            If ((Arg0 == 0x08))
            {
                Name (TMP3, Buffer (0x0100)
                {
                    /* 0000 */  0x0E, 0x00, 0x46, 0x00, 0x07, 0x01, 0x00, 0x00,  // ..F.....
                    /* 0008 */  0x01, 0x07, 0x01, 0x01, 0x00, 0x01, 0x05, 0x00,  // ........
                    /* 0010 */  0x00, 0x00, 0x04, 0x05, 0x00, 0x01, 0x10, 0x01,  // ........
                    /* 0018 */  0x07, 0x03, 0x00, 0x00, 0x03, 0x07, 0x03, 0x01,  // ........
                    /* 0020 */  0x10, 0x02, 0x07, 0x07, 0x00, 0x01, 0x03, 0x07,  // ........
                    /* 0028 */  0x07, 0x01, 0x10, 0x02, 0x07, 0x09, 0x00, 0x02,  // ........
                    /* 0030 */  0x03, 0x07, 0x09, 0x01, 0x20, 0x02, 0x07, 0x0A,  // .... ...
                    /* 0038 */  0x00, 0x03, 0x03, 0x07, 0x0A, 0x01, 0x30, 0x02,  // ......0.
                    /* 0040 */  0x07, 0x0B, 0x00, 0x04, 0x03, 0x07, 0x0B, 0x01,  // ........
                    /* 0048 */  0x30, 0x02, 0x07, 0x0C, 0x00, 0x06, 0x03         // 0......
                })
                CreateWordField (TMP3, Zero, ATNO)
                CreateWordField (TMP3, 0x02, ATSZ)
                TMP3 [0x0E] = ADPM (MXD2, One)
                TMP3 [0x13] = ADPM (MXD2, One)
                TMP3 [0x18] = ADPM (MXD3, One)
                TMP3 [0x1D] = ADPM (MXD3, 0x02)
                TMP3 [0x22] = ADPM (MXD4, One)
                TMP3 [0x27] = ADPM (MXD4, 0x02)
                TMP3 [0x2C] = ADPM (MXD5, One)
                TMP3 [0x31] = ADPM (MXD5, 0x02)
                TMP3 [0x36] = ADPM (MXD6, One)
                TMP3 [0x3B] = ADPM (MXD6, 0x02)
                TMP3 [0x40] = ADPM (MXD7, One)
                TMP3 [0x45] = ADPM (MXD7, 0x02)
                If ((SGFL & One))
                {
                    ATNO = (ATNO + One)
                    ATSZ = (ATSZ + 0x05)
                }

                Return (TMP3) /* \_SB_.PCI0.GFX0.ATPX.TMP3 */
            }

            Return (Zero)
        }

        Method (ATRM, 2, Serialized)
        {
            Local0 = Arg0
            Local1 = Arg1
            If ((Local1 > 0x1000))
            {
                Local1 = 0x1000
            }

            If ((Local0 > 0x00010000))
            {
                Return (Buffer (Local1)
                {
                     0x00                                             // .
                })
            }

            If ((Local0 > RVBS))
            {
                Return (Buffer (Local1)
                {
                     0x00                                             // .
                })
            }

            Local3 = (Local1 * 0x08)
            Name (ROM1, Buffer (0x8000)
            {
                 0x00                                             // .
            })
            Name (ROM2, Buffer (Local1)
            {
                 0x00                                             // .
            })
            If ((Local0 < 0x8000))
            {
                ROM1 = RBF1 /* \_SB_.PCI0.GFX0.RBF1 */
            }
            Else
            {
                Local0 -= 0x8000
                ROM1 = RBF2 /* \_SB_.PCI0.GFX0.RBF2 */
            }

            Local2 = (Local0 * 0x08)
            CreateField (ROM1, Local2, Local3, TMPB)
            ROM2 = TMPB /* \_SB_.PCI0.GFX0.ATRM.TMPB */
            Return (ROM2) /* \_SB_.PCI0.GFX0.ATRM.ROM2 */
        }

        Method (INDL, 0, Serialized)
        {
            NXD1 = Zero
            NXD2 = Zero
            NXD3 = Zero
            NXD4 = Zero
            NXD5 = Zero
            NXD6 = Zero
            NXD7 = Zero
            NXD8 = Zero
        }

        Method (SNXD, 1, Serialized)
        {
            INDL ()
            Local0 = Arg0
            If ((Local0 & 0x02))
            {
                NXD1 = One
            }

            If ((Local0 & One))
            {
                NXD2 = One
            }

            If ((Local0 & 0x08))
            {
                NXD3 = One
            }

            If ((Local0 & 0x80))
            {
                NXD4 = One
            }

            If ((Local0 & 0x0200))
            {
                NXD5 = One
            }

            If ((Local0 & 0x0400))
            {
                NXD6 = One
            }

            If ((Local0 & 0x0800))
            {
                NXD7 = One
            }
        }

        Method (ATIF, 2, Serialized)
        {
            If ((\_SB.PCI0.PEG0.VEID == 0x1002))
            {
                \_SB.PCI0.LPCB.EC0.VGAD = One
            }

            If ((\_SB.PCI0.PEG0.VEID == 0x1002))
            {
                If (\_SB.PCI0.LPCB.EC0.ADPT)
                {
                    \_SB.PCI0.PEG0.PEGP.P2PD.DGPU.ASPM = Zero
                    \_SB.PCI0.PEG0.PEGP.P2PD.ASPM = Zero
                    \_SB.PCI0.PEG0.PEGP.ASPM = Zero
                    \_SB.PCI0.ASPM = Zero
                }
                Else
                {
                    \_SB.PCI0.ASPM = 0x02
                    \_SB.PCI0.PEG0.PEGP.ASPM = 0x02
                    \_SB.PCI0.PEG0.PEGP.P2PD.ASPM = 0x02
                    \_SB.PCI0.PEG0.PEGP.P2PD.DGPU.ASPM = 0x02
                }
            }

            If ((Arg0 == Zero))
            {
                Name (TMP0, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP0, Zero, F0SS)
                CreateWordField (TMP0, 0x02, F0IV)
                CreateDWordField (TMP0, 0x04, F0SN)
                CreateDWordField (TMP0, 0x08, F0SF)
                F0SS = 0x0C
                F0IV = One
                F0SN = 0x1F84
                F0SF = 0x00100003
                Return (TMP0) /* \_SB_.PCI0.GFX0.ATIF.TMP0 */
            }

            If ((Arg0 == One))
            {
                Name (TMP1, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP1, Zero, F1SS)
                CreateDWordField (TMP1, 0x02, F1VF)
                CreateDWordField (TMP1, 0x06, F1FG)
                F1SS = 0x0A
                F1VF = 0x03
                F1FG = One
                Return (TMP1) /* \_SB_.PCI0.GFX0.ATIF.TMP1 */
            }

            If ((Arg0 == 0x02))
            {
                Name (TMP2, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP2, Zero, F2SS)
                CreateDWordField (TMP2, 0x02, F2PR)
                CreateByteField (TMP2, 0x06, F2EM)
                CreateByteField (TMP2, 0x07, F2TG)
                CreateByteField (TMP2, 0x08, F2SI)
                CreateByteField (TMP2, 0x09, F2FG)
                CreateByteField (TMP2, 0x0A, F2FI)
                CreateByteField (TMP2, 0x0B, F2SP)
                CreateByteField (TMP2, 0x0C, F2BL)
                CreateByteField (TMP2, 0x0D, F2PG)
                CreateDWordField (TMP2, 0x0E, F2PV)
                F2SS = 0x12
                Name (STS2, Zero)
                STS2 |= DSWR /* \_SB_.PCI0.GFX0.ATIF.STS2 */
                STS2 |= (PXGS << 0x06) /* \_SB_.PCI0.GFX0.ATIF.STS2 */
                F2PR = STS2 /* \_SB_.PCI0.GFX0.ATIF.STS2 */
                DSWR = Zero
                PXGS = Zero
                Name (DTGP, 0x78)
                If (\_SB.PCI0.LPCB.EC0.ADPT)
                {
                    Local0 = \_SB.PCI0.LPCB.EC0.ACPL /* External reference */
                }
                Else
                {
                    Local0 = \_SB.PCI0.LPCB.EC0.DCPL /* External reference */
                }

                If (((Local0 == Zero) || (Local0 == 0xFF)))
                {
                    Local0 = DTGP /* \_SB_.PCI0.GFX0.ATIF.DTGP */
                }

                F2PG = 0x02
                F2PV = (Local0 << 0x08)
                F2PR |= 0x1000
                Return (TMP2) /* \_SB_.PCI0.GFX0.ATIF.TMP2 */
            }

            If ((Arg0 == 0x03))
            {
                Name (TMP3, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TMP3, Zero, F3SS)
                CreateWordField (TMP3, 0x02, F3SD)
                CreateWordField (Arg1, Zero, AI3S)
                CreateWordField (Arg1, 0x02, SLDS)
                CreateWordField (Arg1, 0x04, CODS)
                CACD = SLDS /* \_SB_.PCI0.GFX0.ATIF.SLDS */
                CCND = CODS /* \_SB_.PCI0.GFX0.ATIF.CODS */
                If (\ECON)
                {
                    If ((\_SB.PCI0.LPCB.H_EC.LSTE == One))
                    {
                        CCND |= One
                    }
                }

                F3SS = 0x04
                TLSN = CTOI (CACD)
                Local1 = CACD /* \_SB_.PCI0.GFX0.CACD */
                Local0 = NTLE /* \_SB_.PCI0.GFX0.NTLE */
                While (Local0)
                {
                    Local1 = NATL (TLSN)
                    If ((Local1 != Zero))
                    {
                        If (((Local1 & CCND) == Local1))
                        {
                            Local0 = One
                        }
                    }

                    Local0--
                    TLSN++
                    If ((TLSN > NTLE))
                    {
                        TLSN = One
                    }
                }

                SNXD (Local1)
                NACD = Local1
                F3SD = NACD /* \_SB_.PCI0.GFX0.NACD */
                Return (TMP3) /* \_SB_.PCI0.GFX0.ATIF.TMP3 */
            }

            If ((Arg0 == 0x15))
            {
                Name (TM21, Buffer (0x0100)
                {
                     0x00                                             // .
                })
                CreateWordField (TM21, Zero, F21N)
                CreateWordField (TM21, 0x02, F21S)
                CreateWordField (TM21, 0x04, EGP1)
                CreateWordField (TM21, 0x06, EGB1)
                F21N = One
                F21S = 0x08
                EGP1 = One
                EGB1 = \EGBN /* External reference */
                Return (TM21) /* \_SB_.PCI0.GFX0.ATIF.TM21 */
            }

            Return (Zero)
        }

        Method (CTOI, 1, NotSerialized)
        {
            If ((NTLE != Zero))
            {
                If ((TLE1 == Arg0))
                {
                    Return (One)
                }

                If ((TLE2 == Arg0))
                {
                    Return (0x02)
                }

                If ((TLE3 == Arg0))
                {
                    Return (0x03)
                }

                If ((TLE4 == Arg0))
                {
                    Return (0x04)
                }

                If ((TLE5 == Arg0))
                {
                    Return (0x05)
                }

                If ((TLE6 == Arg0))
                {
                    Return (0x06)
                }

                If ((TLE7 == Arg0))
                {
                    Return (0x07)
                }

                If ((TLE8 == Arg0))
                {
                    Return (0x08)
                }

                If ((TLE9 == Arg0))
                {
                    Return (0x09)
                }

                If ((TL10 == Arg0))
                {
                    Return (0x0A)
                }

                If ((TL11 == Arg0))
                {
                    Return (0x0B)
                }

                If ((TL12 == Arg0))
                {
                    Return (0x0C)
                }

                If ((TL13 == Arg0))
                {
                    Return (0x0D)
                }

                If ((TL14 == Arg0))
                {
                    Return (0x0E)
                }

                If ((TL15 == Arg0))
                {
                    Return (0x0F)
                }
            }

            Return (One)
        }

        Method (NATL, 1, NotSerialized)
        {
            If ((NTLE != Zero))
            {
                If ((Arg0 == One))
                {
                    Return (TLE2) /* \_SB_.PCI0.GFX0.TLE2 */
                }

                If ((Arg0 == 0x02))
                {
                    Return (TLE3) /* \_SB_.PCI0.GFX0.TLE3 */
                }

                If ((Arg0 == 0x03))
                {
                    Return (TLE4) /* \_SB_.PCI0.GFX0.TLE4 */
                }

                If ((Arg0 == 0x04))
                {
                    Return (TLE5) /* \_SB_.PCI0.GFX0.TLE5 */
                }

                If ((Arg0 == 0x05))
                {
                    Return (TLE6) /* \_SB_.PCI0.GFX0.TLE6 */
                }

                If ((Arg0 == 0x06))
                {
                    Return (TLE7) /* \_SB_.PCI0.GFX0.TLE7 */
                }

                If ((Arg0 == 0x07))
                {
                    Return (TLE8) /* \_SB_.PCI0.GFX0.TLE8 */
                }

                If ((Arg0 == 0x08))
                {
                    Return (TLE9) /* \_SB_.PCI0.GFX0.TLE9 */
                }

                If ((Arg0 == 0x09))
                {
                    Return (TL10) /* \_SB_.PCI0.GFX0.TL10 */
                }

                If ((Arg0 == 0x0A))
                {
                    Return (TL11) /* \_SB_.PCI0.GFX0.TL11 */
                }

                If ((Arg0 == 0x0B))
                {
                    Return (TL12) /* \_SB_.PCI0.GFX0.TL12 */
                }

                If ((Arg0 == 0x0C))
                {
                    Return (TL13) /* \_SB_.PCI0.GFX0.TL13 */
                }

                If ((Arg0 == 0x0D))
                {
                    Return (TL14) /* \_SB_.PCI0.GFX0.TL14 */
                }

                If ((Arg0 == 0x0E))
                {
                    Return (TL15) /* \_SB_.PCI0.GFX0.TL15 */
                }

                If ((Arg0 == 0x0F))
                {
                    Return (TLE1) /* \_SB_.PCI0.GFX0.TLE1 */
                }
            }

            Return (Zero)
        }
    }

    Method (IDAB, 0, Serialized)
    {
        If (CondRefOf (\_SB.PCI0.GFX0.IDAB))
        {
            \_SB.PCI0.GFX0.IDAB ()
        }
    }

    Method (HGAS, 0, NotSerialized)
    {
        \_SB.PCI0.GFX0.PXGS = One
        Notify (\_SB.PCI0.GFX0, 0x81) // Information Change
    }

    Method (HBRT, 1, Serialized)
    {
        If ((0x04 & DSEN))
        {
            If ((Arg0 == 0x04))
            {
                Notify (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU.DD02, 0x87) // Device-Specific
            }

            If ((Arg0 == 0x03))
            {
                Notify (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU.DD02, 0x86) // Device-Specific
            }
        }
    }

    Method (HPFS, 0, Serialized)
    {
        If ((\_SB.PCI0.GFX0.GSTP != One))
        {
            If ((\_SB.PCI0.GFX0.AGXA == Zero))
            {
                \_SB.PCI0.GFX0.AINT (0x02, Zero)
            }
            Else
            {
                \_SB.PCI0.GFX0.EMDR = One
                If ((\_SB.PCI0.GFX0.EXPM == 0x02))
                {
                    \_SB.PCI0.GFX0.EXPM = Zero
                }
                Else
                {
                    \_SB.PCI0.GFX0.EXPM++
                }

                Notify (\_SB.PCI0.GFX0, 0x81) // Information Change
            }
        }
    }

    Method (HNOT, 1, Serialized)
    {
        Switch (ToInteger (Arg0))
        {
            Case (One)
            {
                If ((\_SB.PCI0.GFX0.GSTP != One))
                {
                    If ((SGMD == 0x02))
                    {
                        If ((\_SB.PCI0.GFX0.AGXA == Zero))
                        {
                            Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                        }

                        If ((\_SB.PCI0.GFX0.AGXA == One))
                        {
                            Notify (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU, 0x80) // Status Change
                        }
                    }
                    Else
                    {
                        \_SB.PCI0.GFX0.DSWR = One
                        Notify (\_SB.PCI0.GFX0, 0x81) // Information Change
                    }
                }
            }
            Case (0x02)
            {
                If ((SGMD == 0x02))
                {
                    If ((\_SB.PCI0.GFX0.AGXA == Zero))
                    {
                        Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                    }

                    If ((\_SB.PCI0.GFX0.AGXA == One))
                    {
                        Notify (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU, 0x80) // Status Change
                    }
                }
                Else
                {
                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                }
            }
            Case (0x04)
            {
                If ((SGMD == 0x02))
                {
                    If ((\_SB.PCI0.GFX0.AGXA == Zero))
                    {
                        Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                    }

                    If ((\_SB.PCI0.GFX0.AGXA == One))
                    {
                        Notify (\_SB.PCI0.PEG0.PEGP.P2PD.DGPU, 0x80) // Status Change
                    }
                }
                Else
                {
                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                }
            }
            Default
            {
                Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
            }

        }
    }
}

