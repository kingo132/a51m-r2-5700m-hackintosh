// A51m R2 device-resume notification, without an optional debug dependency.
// System _WAK belongs to OSPM; a device _PS0 must not replay system resume.
DefinitionBlock ("", "SSDT", 2, "A51M", "AOACWake", 0x00000001)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.LID0, DeviceObj)

    Scope (\_SB.PCI0.LPCB)
    {
        If (_OSI ("Darwin"))
        {
            Name (AWPN, Zero)

            Method (_PS3, 0, Serialized)
            {
                AWPN = One
            }

            Method (_PS0, 0, Serialized)
            {
                // Cold boot and repeated D0 requests do not synthesize a wake.
                If (AWPN)
                {
                    AWPN = Zero
                    Notify (LID0, 0x80)
                }
            }
        }
    }
}
