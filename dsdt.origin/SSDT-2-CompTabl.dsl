/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200528 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ./SSDT-2-CompTabl.aml, Mon Aug 23 21:16:16 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000100 (256)
 *     Revision         0x02
 *     Checksum         0x3A
 *     OEM ID           "Compal"
 *     OEM Table ID     "CompTabl"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "Compal", "CompTabl", 0x00003000)
{
    OperationRegion (COMP, SystemMemory, 0x81F76798, 0x0200)
    Field (COMP, AnyAcc, Lock, Preserve)
    {
        RSR0,   32, 
        BDDD,   8, 
        CPFB,   8, 
        PBTI,   8, 
        BRLV,   8, 
        CAVR,   8, 
        TJMA,   16, 
        CORE,   8, 
        TPDF,   8, 
        TPLF,   8, 
        TPDD,   8, 
        TMUD,   8, 
        CTUR,   8, 
        CUCB,   32, 
        CG21,   8, 
        CG22,   8, 
        CG23,   8, 
        CG24,   8, 
        CG25,   8, 
        CG26,   8, 
        CG27,   8, 
        CG28,   8, 
        CG29,   8, 
        CG30,   8, 
        CG31,   8, 
        SFNO,   16, 
        STDT,   16, 
        BFDT,   1024, 
        ESMS,   8, 
        ESMB,   256, 
        RSR1,   472, 
        IDFD,   1024, 
        RSR2,   512, 
        CPP0,   8, 
        CPP1,   8, 
        CPP2,   8, 
        CPP3,   8, 
        RSR3,   480
    }
}

