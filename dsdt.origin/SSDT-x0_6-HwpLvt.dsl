/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-x0_6-HwpLvt.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000BEA (3050)
 *     Revision         0x02
 *     Checksum         0x68
 *     OEM ID           "PmRef"
 *     OEM Table ID     "HwpLvt"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "PmRef", "HwpLvt", 0x00003000)
{
    External (_SB_.CFGD, FieldUnitObj)
    External (_SB_.ITBM, IntObj)
    External (_SB_.OSCP, IntObj)
    External (_SB_.PR00, DeviceObj)
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
    External (TCNT, FieldUnitObj)

    Scope (\_GPE)
    {
        Method (HLVT, 0, Serialized)
        {
            Name (NTVL, 0x83)
            If (((\_SB.ITBM == One) && (\_SB.OSCP & 0x1000)))
            {
                NTVL = 0x85
            }

            Switch (ToInteger (TCNT))
            {
                Case (0x14)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                    Notify (\_SB.PR14, NTVL)
                    Notify (\_SB.PR15, NTVL)
                    Notify (\_SB.PR16, NTVL)
                    Notify (\_SB.PR17, NTVL)
                    Notify (\_SB.PR18, NTVL)
                    Notify (\_SB.PR19, NTVL)
                }
                Case (0x13)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                    Notify (\_SB.PR14, NTVL)
                    Notify (\_SB.PR15, NTVL)
                    Notify (\_SB.PR16, NTVL)
                    Notify (\_SB.PR17, NTVL)
                    Notify (\_SB.PR18, NTVL)
                }
                Case (0x12)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                    Notify (\_SB.PR14, NTVL)
                    Notify (\_SB.PR15, NTVL)
                    Notify (\_SB.PR16, NTVL)
                    Notify (\_SB.PR17, NTVL)
                }
                Case (0x11)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                    Notify (\_SB.PR14, NTVL)
                    Notify (\_SB.PR15, NTVL)
                    Notify (\_SB.PR16, NTVL)
                }
                Case (0x10)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                    Notify (\_SB.PR14, NTVL)
                    Notify (\_SB.PR15, NTVL)
                }
                Case (0x0E)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                    Notify (\_SB.PR12, NTVL)
                    Notify (\_SB.PR13, NTVL)
                }
                Case (0x0C)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                    Notify (\_SB.PR10, NTVL)
                    Notify (\_SB.PR11, NTVL)
                }
                Case (0x0A)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                    Notify (\_SB.PR08, NTVL)
                    Notify (\_SB.PR09, NTVL)
                }
                Case (0x08)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                    Notify (\_SB.PR07, NTVL)
                }
                Case (0x07)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                    Notify (\_SB.PR06, NTVL)
                }
                Case (0x06)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                    Notify (\_SB.PR05, NTVL)
                }
                Case (0x05)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                    Notify (\_SB.PR04, NTVL)
                }
                Case (0x04)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                    Notify (\_SB.PR03, NTVL)
                }
                Case (0x03)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                    Notify (\_SB.PR02, NTVL)
                }
                Case (0x02)
                {
                    Notify (\_SB.PR00, NTVL)
                    Notify (\_SB.PR01, NTVL)
                }
                Default
                {
                    Notify (\_SB.PR00, NTVL)
                }

            }
        }
    }
}

