/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-x0_4-Cpu0Hwp.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000016C (364)
 *     Revision         0x02
 *     Checksum         0x87
 *     OEM ID           "PmRef"
 *     OEM Table ID     "Cpu0Hwp"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "PmRef", "Cpu0Hwp", 0x00003000)
{
    External (_SB_.CFGD, IntObj)
    External (_SB_.HWPE, IntObj)
    External (_SB_.HWPV, IntObj)
    External (_SB_.ITBM, IntObj)
    External (_SB_.ITBP, IntObj)
    External (_SB_.LMPS, IntObj)
    External (_SB_.OSCP, IntObj)
    External (_SB_.PR00, DeviceObj)
    External (_SB_.PR00.CPC2, PkgObj)
    External (_SB_.PR00.CPOC, PkgObj)
    External (_SB_.PR00.CPTB, PkgObj)
    External (CPC2, IntObj)
    External (CPOC, IntObj)
    External (CPTB, IntObj)
    External (TCNT, FieldUnitObj)

    Scope (\_SB.PR00)
    {
        Method (_CPC, 0, NotSerialized)  // _CPC: Continuous Performance Control
        {
            If (CondRefOf (\_SB.HWPE))
            {
                If (\_SB.HWPE)
                {
                    If (((\_SB.ITBM == One) && (\_SB.OSCP & 0x1000)))
                    {
                        If (((\_SB.CFGD & 0x01000000) && (\_SB.ITBP == Zero)))
                        {
                            Return (CPOC) /* External reference */
                        }
                        Else
                        {
                            Return (CPTB) /* External reference */
                        }
                    }
                    ElseIf ((\_SB.CFGD & 0x01000000))
                    {
                        Return (CPOC) /* External reference */
                    }
                    Else
                    {
                        Return (CPC2) /* External reference */
                    }
                }
            }
        }
    }
}

