/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-9-TbtTypeC.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000027BC (10172)
 *     Revision         0x02
 *     Checksum         0xA3
 *     OEM ID           "ALWARE"
 *     OEM Table ID     "TbtTypeC"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "ALWARE", "TbtTypeC", 0x00000000)
{
    External (_SB_.PCI0.RP01.PXSX, DeviceObj)
    External (_SB_.PCI0.RP05.PXSX, DeviceObj)
    External (_SB_.PCI0.RP09.PXSX, DeviceObj)
    External (_SB_.PCI0.RP13.PXSX, DeviceObj)
    External (_SB_.PCI0.RP17.PXSX, DeviceObj)
    External (_SB_.PCI0.RP21.PXSX, DeviceObj)
    External (_SB_.UBTC.RUCC, MethodObj)    // 2 Arguments
    External (DPM1, IntObj)
    External (DPM2, IntObj)
    External (DPM3, IntObj)
    External (NDUS, IntObj)
    External (NTUS, IntObj)
    External (RPS0, IntObj)
    External (RPS1, IntObj)
    External (TBTS, IntObj)
    External (TP1D, IntObj)
    External (TP1P, IntObj)
    External (TP1T, IntObj)
    External (TP2D, IntObj)
    External (TP2P, IntObj)
    External (TP2T, IntObj)
    External (TP3D, IntObj)
    External (TP3P, IntObj)
    External (TP3T, IntObj)
    External (TP4D, IntObj)
    External (TP4P, IntObj)
    External (TP4T, IntObj)
    External (TP5D, IntObj)
    External (TP5P, IntObj)
    External (TP5T, IntObj)
    External (TP6D, IntObj)
    External (TP6P, IntObj)
    External (TP6T, IntObj)

    If (((TBTS == One) && ((RPS0 == One) || (RPS1 == One))))
    {
        If (CondRefOf (\_SB.PCI0.RP01.PXSX))
        {
            Scope (\_SB.PCI0.RP01.PXSX)
            {
                Name (TURP, One)
                Device (TBDU)
                {
                    Name (_ADR, 0x00020000)  // _ADR: Address
                    Device (XHC)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = 0xFF
                            PCKG [One] = 0xFF
                            Return (PCKG) /* \_SB_.PCI0.RP01.PXSX.TBDU.XHC_._UPC.PCKG */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Name (PLDB, Package (0x01)
                            {
                                Buffer (0x14)
                                {
                                    /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                    /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                                }
                            })
                            Return (PLDB) /* \_SB_.PCI0.RP01.PXSX.TBDU.XHC_._PLD.PLDB */
                        }

                        Device (RHUB)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (SLMS, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return ((TP1D & One))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return ((TP2D & One))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return ((TP3D & One))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return ((TP4D & One))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return ((TP5D & One))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return ((TP6D & One))
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (FPCP, 2, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (\_SB.UBTC.RUCC (One, Arg1))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x02, Arg1))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x03, Arg1))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x04, Arg1))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x05, Arg1))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x06, Arg1))
                                }
                                ElseIf ((Arg1 == One))
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }

                            Method (FPSP, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (One)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (TPLD, 2, Serialized)
                            {
                                Name (PCKG, Package (0x01)
                                {
                                    Buffer (0x10){}
                                })
                                CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                                REV = One
                                CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                                VISI = Arg0
                                CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                                GPOS = Arg1
                                CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                                SHAP = One
                                CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                                WID = 0x08
                                CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                                HGT = 0x03
                                Return (PCKG) /* \_SB_.PCI0.RP01.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                            }

                            Method (TUPC, 2, Serialized)
                            {
                                Name (PCKG, Package (0x04)
                                {
                                    One, 
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                                PCKG [Zero] = Arg0
                                PCKG [One] = Arg1
                                Return (PCKG) /* \_SB_.PCI0.RP01.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (HS01)
                                {
                                    Name (_ADR, One)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (HS02)
                                {
                                    Name (_ADR, 0x02)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (SS01)
                                {
                                    Name (_ADR, 0x03)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (TUPC (One, 0x09))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (TPLD (One, 0x0B))
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (SS02)
                                {
                                    Name (_ADR, 0x04)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (Zero, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (Zero, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (HS03)
                                {
                                    Name (_ADR, 0x05)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (HS04)
                                {
                                    Name (_ADR, 0x06)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (SS03)
                                {
                                    Name (_ADR, 0x07)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x03, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (SS04)
                                {
                                    Name (_ADR, 0x08)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x04, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (((TBTS == One) && ((RPS0 == 0x05) || (RPS1 == 0x05))))
    {
        If (CondRefOf (\_SB.PCI0.RP05.PXSX))
        {
            Scope (\_SB.PCI0.RP05.PXSX)
            {
                Name (TURP, 0x05)
                Device (TBDU)
                {
                    Name (_ADR, 0x00020000)  // _ADR: Address
                    Device (XHC)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = 0xFF
                            PCKG [One] = 0xFF
                            Return (PCKG) /* \_SB_.PCI0.RP05.PXSX.TBDU.XHC_._UPC.PCKG */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Name (PLDB, Package (0x01)
                            {
                                Buffer (0x14)
                                {
                                    /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                    /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                                }
                            })
                            Return (PLDB) /* \_SB_.PCI0.RP05.PXSX.TBDU.XHC_._PLD.PLDB */
                        }

                        Device (RHUB)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (SLMS, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return ((TP1D & One))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return ((TP2D & One))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return ((TP3D & One))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return ((TP4D & One))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return ((TP5D & One))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return ((TP6D & One))
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (FPCP, 2, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (\_SB.UBTC.RUCC (One, Arg1))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x02, Arg1))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x03, Arg1))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x04, Arg1))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x05, Arg1))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x06, Arg1))
                                }
                                ElseIf ((Arg1 == One))
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }

                            Method (FPSP, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (One)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (TPLD, 2, Serialized)
                            {
                                Name (PCKG, Package (0x01)
                                {
                                    Buffer (0x10){}
                                })
                                CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                                REV = One
                                CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                                VISI = Arg0
                                CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                                GPOS = Arg1
                                CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                                SHAP = One
                                CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                                WID = 0x08
                                CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                                HGT = 0x03
                                Return (PCKG) /* \_SB_.PCI0.RP05.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                            }

                            Method (TUPC, 2, Serialized)
                            {
                                Name (PCKG, Package (0x04)
                                {
                                    One, 
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                                PCKG [Zero] = Arg0
                                PCKG [One] = Arg1
                                Return (PCKG) /* \_SB_.PCI0.RP05.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (HS01)
                                {
                                    Name (_ADR, One)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (HS02)
                                {
                                    Name (_ADR, 0x02)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (SS01)
                                {
                                    Name (_ADR, 0x03)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (TUPC (One, 0x09))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (TPLD (One, 0x0B))
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (SS02)
                                {
                                    Name (_ADR, 0x04)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (Zero, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (Zero, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (HS03)
                                {
                                    Name (_ADR, 0x05)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (HS04)
                                {
                                    Name (_ADR, 0x06)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (SS03)
                                {
                                    Name (_ADR, 0x07)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x03, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (SS04)
                                {
                                    Name (_ADR, 0x08)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x04, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (((TBTS == One) && ((RPS0 == 0x09) || (RPS1 == 0x09))))
    {
        If (CondRefOf (\_SB.PCI0.RP09.PXSX))
        {
            Scope (\_SB.PCI0.RP09.PXSX)
            {
                Name (TURP, 0x09)
                Device (TBDU)
                {
                    Name (_ADR, 0x00020000)  // _ADR: Address
                    Device (XHC)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = 0xFF
                            PCKG [One] = 0xFF
                            Return (PCKG) /* \_SB_.PCI0.RP09.PXSX.TBDU.XHC_._UPC.PCKG */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Name (PLDB, Package (0x01)
                            {
                                Buffer (0x14)
                                {
                                    /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                    /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                    /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                                }
                            })
                            Return (PLDB) /* \_SB_.PCI0.RP09.PXSX.TBDU.XHC_._PLD.PLDB */
                        }

                        Device (RHUB)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (SLMS, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return ((TP1D & One))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return ((TP2D & One))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return ((TP3D & One))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return ((TP4D & One))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return ((TP5D & One))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return ((TP6D & One))
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (FPCP, 2, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (\_SB.UBTC.RUCC (One, Arg1))
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x02, Arg1))
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x03, Arg1))
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x04, Arg1))
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x05, Arg1))
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (\_SB.UBTC.RUCC (0x06, Arg1))
                                }
                                ElseIf ((Arg1 == One))
                                {
                                    Return (TUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (TPLD (Zero, Zero))
                                }
                            }

                            Method (FPSP, 1, Serialized)
                            {
                                Local0 = (TURP << 0x02)
                                Local0 |= One
                                If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                                {
                                    Return (One)
                                }
                                ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                                {
                                    Return (One)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (TPLD, 2, Serialized)
                            {
                                Name (PCKG, Package (0x01)
                                {
                                    Buffer (0x10){}
                                })
                                CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                                REV = One
                                CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                                VISI = Arg0
                                CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                                GPOS = Arg1
                                CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                                SHAP = One
                                CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                                WID = 0x08
                                CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                                HGT = 0x03
                                Return (PCKG) /* \_SB_.PCI0.RP09.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                            }

                            Method (TUPC, 2, Serialized)
                            {
                                Name (PCKG, Package (0x04)
                                {
                                    One, 
                                    Zero, 
                                    Zero, 
                                    Zero
                                })
                                PCKG [Zero] = Arg0
                                PCKG [One] = Arg1
                                Return (PCKG) /* \_SB_.PCI0.RP09.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (HS01)
                                {
                                    Name (_ADR, One)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (One) == Zero))
                                        {
                                            Return (FPCP (One, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (HS02)
                                {
                                    Name (_ADR, 0x02)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x02) == Zero))
                                        {
                                            Return (FPCP (0x02, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (One) == One))
                            {
                                Device (SS01)
                                {
                                    Name (_ADR, 0x03)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (TUPC (One, 0x09))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (TPLD (One, 0x0B))
                                    }
                                }
                            }

                            If ((FPSP (0x02) == One))
                            {
                                Device (SS02)
                                {
                                    Name (_ADR, 0x04)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (Zero, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (Zero, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (HS03)
                                {
                                    Name (_ADR, 0x05)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x03) == Zero))
                                        {
                                            Return (FPCP (0x03, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (HS04)
                                {
                                    Name (_ADR, 0x06)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, One))
                                        }
                                        Else
                                        {
                                            Return (TUPC (Zero, Zero))
                                        }
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        If ((SLMS (0x04) == Zero))
                                        {
                                            Return (FPCP (0x04, 0x02))
                                        }
                                        Else
                                        {
                                            Return (TPLD (Zero, Zero))
                                        }
                                    }
                                }
                            }

                            If ((FPSP (0x03) == One))
                            {
                                Device (SS03)
                                {
                                    Name (_ADR, 0x07)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x03, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                }
                            }

                            If ((FPSP (0x04) == One))
                            {
                                Device (SS04)
                                {
                                    Name (_ADR, 0x08)  // _ADR: Address
                                    Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                    {
                                        Return (FPCP (0x04, One))
                                    }

                                    Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (((TBTS == One) && ((RPS0 == 0x0D) || (RPS1 == 0x0D))))
    {
        Scope (\_SB.PCI0.RP13.PXSX)
        {
            Name (TURP, 0x0D)
            Device (TBDU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Device (XHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (PCKG, Package (0x04)
                        {
                            One, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        PCKG [Zero] = 0xFF
                        PCKG [One] = 0xFF
                        Return (PCKG) /* \_SB_.PCI0.RP13.PXSX.TBDU.XHC_._UPC.PCKG */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDB, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDB) /* \_SB_.PCI0.RP13.PXSX.TBDU.XHC_._PLD.PLDB */
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (SLMS, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return ((TP1D & One))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return ((TP2D & One))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return ((TP3D & One))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return ((TP4D & One))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return ((TP5D & One))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return ((TP6D & One))
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (FPCP, 2, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (\_SB.UBTC.RUCC (One, Arg1))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x02, Arg1))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x03, Arg1))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x04, Arg1))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x05, Arg1))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x06, Arg1))
                            }
                            ElseIf ((Arg1 == One))
                            {
                                Return (TUPC (Zero, Zero))
                            }
                            Else
                            {
                                Return (TPLD (Zero, Zero))
                            }
                        }

                        Method (FPSP, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (TPLD, 2, Serialized)
                        {
                            Name (PCKG, Package (0x01)
                            {
                                Buffer (0x10){}
                            })
                            CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                            REV = One
                            CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                            VISI = Arg0
                            CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                            GPOS = Arg1
                            CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                            SHAP = One
                            CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                            WID = 0x08
                            CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                            HGT = 0x03
                            Return (PCKG) /* \_SB_.PCI0.RP13.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                        }

                        Method (TUPC, 2, Serialized)
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = Arg0
                            PCKG [One] = Arg1
                            Return (PCKG) /* \_SB_.PCI0.RP13.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (HS01)
                            {
                                Name (_ADR, One)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (HS02)
                            {
                                Name (_ADR, 0x02)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (SS01)
                            {
                                Name (_ADR, 0x03)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (TUPC (One, 0x09))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (TPLD (One, 0x0B))
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (SS02)
                            {
                                Name (_ADR, 0x04)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (Zero, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (Zero, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (HS03)
                            {
                                Name (_ADR, 0x05)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (HS04)
                            {
                                Name (_ADR, 0x06)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (SS03)
                            {
                                Name (_ADR, 0x07)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x03, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x03, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (SS04)
                            {
                                Name (_ADR, 0x08)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x04, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x04, 0x02))
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (((TBTS == One) && ((RPS0 == 0x11) || (RPS1 == 0x11))))
    {
        Scope (\_SB.PCI0.RP17.PXSX)
        {
            Name (TURP, 0x11)
            Device (TBDU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Device (XHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (PCKG, Package (0x04)
                        {
                            One, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        PCKG [Zero] = 0xFF
                        PCKG [One] = 0xFF
                        Return (PCKG) /* \_SB_.PCI0.RP17.PXSX.TBDU.XHC_._UPC.PCKG */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDB, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDB) /* \_SB_.PCI0.RP17.PXSX.TBDU.XHC_._PLD.PLDB */
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (SLMS, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return ((TP1D & One))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return ((TP2D & One))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return ((TP3D & One))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return ((TP4D & One))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return ((TP5D & One))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return ((TP6D & One))
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (FPCP, 2, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (\_SB.UBTC.RUCC (One, Arg1))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x02, Arg1))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x03, Arg1))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x04, Arg1))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x05, Arg1))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x06, Arg1))
                            }
                            ElseIf ((Arg1 == One))
                            {
                                Return (TUPC (Zero, Zero))
                            }
                            Else
                            {
                                Return (TPLD (Zero, Zero))
                            }
                        }

                        Method (FPSP, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (TPLD, 2, Serialized)
                        {
                            Name (PCKG, Package (0x01)
                            {
                                Buffer (0x10){}
                            })
                            CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                            REV = One
                            CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                            VISI = Arg0
                            CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                            GPOS = Arg1
                            CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                            SHAP = One
                            CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                            WID = 0x08
                            CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                            HGT = 0x03
                            Return (PCKG) /* \_SB_.PCI0.RP17.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                        }

                        Method (TUPC, 2, Serialized)
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = Arg0
                            PCKG [One] = Arg1
                            Return (PCKG) /* \_SB_.PCI0.RP17.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (HS01)
                            {
                                Name (_ADR, One)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (HS02)
                            {
                                Name (_ADR, 0x02)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (SS01)
                            {
                                Name (_ADR, 0x03)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (TUPC (One, 0x09))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (TPLD (One, 0x0B))
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (SS02)
                            {
                                Name (_ADR, 0x04)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (Zero, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (Zero, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (HS03)
                            {
                                Name (_ADR, 0x05)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (HS04)
                            {
                                Name (_ADR, 0x06)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (SS03)
                            {
                                Name (_ADR, 0x07)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x03, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x03, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (SS04)
                            {
                                Name (_ADR, 0x08)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x04, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x04, 0x02))
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    If (((TBTS == One) && ((RPS0 == 0x15) || (RPS1 == 0x15))))
    {
        Scope (\_SB.PCI0.RP21.PXSX)
        {
            Name (TURP, 0x15)
            Device (TBDU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Device (XHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Name (PCKG, Package (0x04)
                        {
                            One, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        PCKG [Zero] = 0xFF
                        PCKG [One] = 0xFF
                        Return (PCKG) /* \_SB_.PCI0.RP21.PXSX.TBDU.XHC_._UPC.PCKG */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Name (PLDB, Package (0x01)
                        {
                            Buffer (0x14)
                            {
                                /* 0000 */  0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0008 */  0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  //  .......
                                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF                           // ....
                            }
                        })
                        Return (PLDB) /* \_SB_.PCI0.RP21.PXSX.TBDU.XHC_._PLD.PLDB */
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (SLMS, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return ((TP1D & One))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return ((TP2D & One))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return ((TP3D & One))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return ((TP4D & One))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return ((TP5D & One))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return ((TP6D & One))
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (FPCP, 2, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (\_SB.UBTC.RUCC (One, Arg1))
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x02, Arg1))
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x03, Arg1))
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x04, Arg1))
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x05, Arg1))
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (\_SB.UBTC.RUCC (0x06, Arg1))
                            }
                            ElseIf ((Arg1 == One))
                            {
                                Return (TUPC (Zero, Zero))
                            }
                            Else
                            {
                                Return (TPLD (Zero, Zero))
                            }
                        }

                        Method (FPSP, 1, Serialized)
                        {
                            Local0 = (TURP << 0x02)
                            Local0 |= One
                            If ((((TP1D >> One) == Local0) && (Arg0 == TP1T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP2D >> One) == Local0) && (Arg0 == TP2T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP3D >> One) == Local0) && (Arg0 == TP3T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP4D >> One) == Local0) && (Arg0 == TP4T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP5D >> One) == Local0) && (Arg0 == TP5T)))
                            {
                                Return (One)
                            }
                            ElseIf ((((TP6D >> One) == Local0) && (Arg0 == TP6T)))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (TPLD, 2, Serialized)
                        {
                            Name (PCKG, Package (0x01)
                            {
                                Buffer (0x10){}
                            })
                            CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                            REV = One
                            CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                            VISI = Arg0
                            CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                            GPOS = Arg1
                            CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                            SHAP = One
                            CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                            WID = 0x08
                            CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                            HGT = 0x03
                            Return (PCKG) /* \_SB_.PCI0.RP21.PXSX.TBDU.XHC_.RHUB.TPLD.PCKG */
                        }

                        Method (TUPC, 2, Serialized)
                        {
                            Name (PCKG, Package (0x04)
                            {
                                One, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            PCKG [Zero] = Arg0
                            PCKG [One] = Arg1
                            Return (PCKG) /* \_SB_.PCI0.RP21.PXSX.TBDU.XHC_.RHUB.TUPC.PCKG */
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (HS01)
                            {
                                Name (_ADR, One)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (One) == Zero))
                                    {
                                        Return (FPCP (One, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (HS02)
                            {
                                Name (_ADR, 0x02)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x02) == Zero))
                                    {
                                        Return (FPCP (0x02, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (One) == One))
                        {
                            Device (SS01)
                            {
                                Name (_ADR, 0x03)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (TUPC (One, 0x09))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (TPLD (One, 0x0B))
                                }
                            }
                        }

                        If ((FPSP (0x02) == One))
                        {
                            Device (SS02)
                            {
                                Name (_ADR, 0x04)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (Zero, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (Zero, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (HS03)
                            {
                                Name (_ADR, 0x05)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x03) == Zero))
                                    {
                                        Return (FPCP (0x03, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (HS04)
                            {
                                Name (_ADR, 0x06)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, One))
                                    }
                                    Else
                                    {
                                        Return (TUPC (Zero, Zero))
                                    }
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    If ((SLMS (0x04) == Zero))
                                    {
                                        Return (FPCP (0x04, 0x02))
                                    }
                                    Else
                                    {
                                        Return (TPLD (Zero, Zero))
                                    }
                                }
                            }
                        }

                        If ((FPSP (0x03) == One))
                        {
                            Device (SS03)
                            {
                                Name (_ADR, 0x07)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x03, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x03, 0x02))
                                }
                            }
                        }

                        If ((FPSP (0x04) == One))
                        {
                            Device (SS04)
                            {
                                Name (_ADR, 0x08)  // _ADR: Address
                                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                                {
                                    Return (FPCP (0x04, One))
                                }

                                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                                {
                                    Return (FPCP (0x04, 0x02))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

