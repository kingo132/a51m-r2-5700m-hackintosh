# High-resolution panel timing and EDID configuration

## Scope

High-resolution eDP panels and adapter boards require compatible link hardware,
cables, EDID data and display timings. Missing or incorrect EDID information can
hide otherwise valid modes, but an EDID override cannot add physical bandwidth,
change cable pinout or provide unsupported GPU/adapter capabilities.

The examples below cover AUO panels such as B173ZAN06.1 and B156ZAN05.1. Use
panel-specific timing data and preserve the original EDID before applying an
override. Do not assume that changing a 60 Hz timing to 120 Hz is sufficient.

Adapter-board firmware and EDID changes affect every connected operating system
and require a board-specific recovery method. Software overrides affect only
the system on which they are installed.

## For Windows
To change the EDID information of the Windows system, you need Custom Resolution Utility (CRU), which can be downloaded from [here](https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU) or [cru-1.5.1.zip](https://github.com/kingo132/a51m-r2-5700m-hackintosh/files/14399003/cru-1.5.1.zip)

<img width="497" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/7f066bc9-6d80-4c57-9671-0c3f2ebccc61">

Once you open this app, you will see all the screens connected to this computer, and you can modify their EDID information here. The illustrated examples use AUO9996 (B173ZAN06.6) and AUOB394 (B156ZAN05.1).

<img width="883" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/747a4ea0-7800-4191-bcf8-f2184a3ca369">

For AUOB394 (B156ZAN05.1), the screenshots illustrate adding a detailed mode
in an EDID extension block. Obtain timings from panel documentation or a known
compatible configuration for the exact panel and adapter. Back up the original
EDID and retain a working display mode for recovery.

For AUO9996 (B173ZAN06.6), you can try this parameter.

<img width="466" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/db2dc696-5f74-434e-87df-bfa06ec4252e">


## For Mac OS

On Mac OS, inject or modify the EDID information under folder /Library/Displays/Contents/Resources/Overrides/ like this configuration of AUOB394 (B156ZAN05.1).

<img width="680" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/8c98b791-ed43-4717-88cb-9b562563313b">

Ensure all the numbers in the folder path and the EDID files are correct. For example, 6af is a hex number, and its decimal version is 1711, the vendor ID of AUO. b394 has a decimal version of 45972 and is the product ID of this screen.

Before making this file, you need the binary EDID file of this screen. This binary EDID file can be dumped from another computer with no compatibility issue with this screen. It's best to use a Windows PC to dump it because it has the best compatibility. Once you get this EDID file, you can use this command to get the hex string needed for the EDID information under the Overrides folder.

```
base64 -i that-binary-edid.file
```

An AUOB394 (B156ZAN05.1) example override is available here [DisplayVendorID-6af.zip](https://github.com/kingo132/a51m-r2-5700m-hackintosh/files/14399339/DisplayVendorID-6af.zip). Just unpack it and put it into that folder.

Plus, here is the EDID file for B173ZAN06.1: [DisplayVendorID-6af.zip](https://github.com/kingo132/a51m-r2-5700m-hackintosh/files/14895556/DisplayVendorID-6af.zip)

You can also use SwitchResX to modify EDID under Mac OS. Take AUOB394 as an example. Here is the configuration when using SwitchResX.

<img width="652" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/c73ac6f9-e0e8-4bfb-9f0b-7f5c6b555289">
<img width="853" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/7407ca9d-a0f1-4311-9151-7ce982c3bced">

