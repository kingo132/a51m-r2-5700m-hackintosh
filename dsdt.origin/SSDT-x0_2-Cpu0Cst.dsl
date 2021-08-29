/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-x0_2-Cpu0Cst.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000400 (1024)
 *     Revision         0x02
 *     Checksum         0xD9
 *     OEM ID           "PmRef"
 *     OEM Table ID     "Cpu0Cst"
 *     OEM Revision     0x00003001 (12289)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "PmRef", "Cpu0Cst", 0x00003001)
{
    External (_SB_.PR00, DeviceObj)
    External (C3LT, UnknownObj)
    External (C3MW, UnknownObj)
    External (C6LT, UnknownObj)
    External (C6MW, UnknownObj)
    External (C7LT, UnknownObj)
    External (C7MW, UnknownObj)
    External (CDLT, UnknownObj)
    External (CDLV, UnknownObj)
    External (CDMW, UnknownObj)
    External (CDPW, UnknownObj)
    External (CFGD, UnknownObj)
    External (FEMD, UnknownObj)
    External (FMBL, UnknownObj)
    External (PC00, UnknownObj)
    External (PFLV, UnknownObj)
    External (PWRS, UnknownObj)

    Scope (\_SB.PR00)
    {
        Name (C1TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            One, 
            One, 
            0x03E8
        })
        Name (C3TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000001814, // Address
                    ,)
            }, 

            0x02, 
            Zero, 
            0x01F4
        })
        Name (C6TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000001815, // Address
                    ,)
            }, 

            0x02, 
            Zero, 
            0x015E
        })
        Name (C7TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000001816, // Address
                    ,)
            }, 

            0x02, 
            Zero, 
            0xC8
        })
        Name (CDTM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000001816, // Address
                    ,)
            }, 

            0x03, 
            Zero, 
            Zero
        })
        Name (MWES, ResourceTemplate ()
        {
            Register (FFixedHW, 
                0x01,               // Bit Width
                0x02,               // Bit Offset
                0x0000000000000000, // Address
                0x01,               // Access Size
                )
        })
        Name (AC2V, Zero)
        Name (AC3V, Zero)
        Name (C3ST, Package (0x04)
        {
            0x03, 
            Package (0x00){}, 
            Package (0x00){}, 
            Package (0x00){}
        })
        Name (C2ST, Package (0x03)
        {
            0x02, 
            Package (0x00){}, 
            Package (0x00){}
        })
        Name (C1ST, Package (0x02)
        {
            One, 
            Package (0x00){}
        })
        Name (CSTF, Zero)
        Method (_CST, 0, Serialized)  // _CST: C-States
        {
            If (!CSTF)
            {
                C3TM [0x02] = C3LT /* External reference */
                C6TM [0x02] = C6LT /* External reference */
                C7TM [0x02] = C7LT /* External reference */
                CDTM [0x02] = CDLT /* External reference */
                CDTM [0x03] = CDPW /* External reference */
                DerefOf (CDTM [Zero]) [0x07] = CDLV /* External reference */
                If (((CFGD & 0x0800) && (PC00 & 0x0200)))
                {
                    C1TM [Zero] = MWES /* \_SB_.PR00.MWES */
                    C6TM [Zero] = MWES /* \_SB_.PR00.MWES */
                    C7TM [Zero] = MWES /* \_SB_.PR00.MWES */
                    CDTM [Zero] = MWES /* \_SB_.PR00.MWES */
                    C3TM [Zero] = MWES /* \_SB_.PR00.MWES */
                    DerefOf (C3TM [Zero]) [0x07] = C3MW /* External reference */
                    DerefOf (C6TM [Zero]) [0x07] = C6MW /* External reference */
                    DerefOf (C7TM [Zero]) [0x07] = C7MW /* External reference */
                    DerefOf (CDTM [Zero]) [0x07] = CDMW /* External reference */
                }
                ElseIf (((CFGD & 0x0800) && (PC00 & 0x0100)))
                {
                    C1TM [Zero] = MWES /* \_SB_.PR00.MWES */
                }

                CSTF = Ones
            }

            AC2V = Zero
            AC3V = Zero
            C3ST [One] = C1TM /* \_SB_.PR00.C1TM */
            If ((CFGD & 0x20))
            {
                C3ST [0x02] = C7TM /* \_SB_.PR00.C7TM */
                AC2V = Ones
            }
            ElseIf ((CFGD & 0x10))
            {
                C3ST [0x02] = C6TM /* \_SB_.PR00.C6TM */
                AC2V = Ones
            }
            ElseIf ((CFGD & 0x08))
            {
                C3ST [0x02] = C3TM /* \_SB_.PR00.C3TM */
                AC2V = Ones
            }

            If ((CFGD & 0x4000))
            {
                C3ST [0x03] = CDTM /* \_SB_.PR00.CDTM */
                AC3V = Ones
            }

            If ((AC2V && AC3V))
            {
                Return (C3ST) /* \_SB_.PR00.C3ST */
            }
            ElseIf (AC2V)
            {
                C2ST [One] = DerefOf (C3ST [One])
                C2ST [0x02] = DerefOf (C3ST [0x02])
                Return (C2ST) /* \_SB_.PR00.C2ST */
            }
            ElseIf (AC3V)
            {
                C2ST [One] = DerefOf (C3ST [One])
                C2ST [0x02] = DerefOf (C3ST [0x03])
                DerefOf (C2ST [0x02]) [One] = 0x02
                Return (C2ST) /* \_SB_.PR00.C2ST */
            }
            Else
            {
                C1ST [One] = DerefOf (C3ST [One])
                Return (C1ST) /* \_SB_.PR00.C1ST */
            }
        }
    }
}

