# How to make any high resolution and refresh rate DIY screen work on Windows and Mac OS.

## The problem and the fix
Many people are playing with high-resolution and refresh-rate portable DIY screens because of their fine picture, smooth gaming and mouse moving, and incredible brightness. I have played with these screens such as B173ZAN06.6 (4k@120hz, 1000nit HDR), B173ZAN06.1 (4k@120hz, 500nit), B173ZAN06.0 (4k@60hz, 400nit), B156ZAN05.1 (4k@120hz, 400nit). Enthusiasts developed many adapter circuit modules for these DIY screens. They can be found on XianYu, Taobao or Ebay. I purchased more than five different kinds of these adapter boards. The biggest problem of these DIY setups is the compatibility. They are susceptible to the video cable, the graphics card, and the operating system. However, from my experience, all these compatibility problems are the error defined or missing EDID information inside the OS. So, I summarized how to fix this compatible issue here to help those who encounter this kind of problem.

The key reason these screens have compatibility issues is that these screens are too avant-garde, and the operating system does not know the exact information to set the correct refresh rate. Therefore, we only need to manually modify or inject the EDID information to add or change this refresh rate information. 4k@60hz is almost supported by most of the OS by now. 4k@120hz and higher refresh rates have more problems. Hence, most of the time, manually adding the refresh rate information of 4k@120hz will fix the problem.

## For Windows
To change the EDID information of the Windows system, you need Custom Resolution Utility (CRU), which can be downloaded from [here](https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU) or [cru-1.5.1.zip](https://github.com/kingo132/a51m-r2-5700m-hackintosh/files/14399003/cru-1.5.1.zip)

<img width="497" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/7f066bc9-6d80-4c57-9671-0c3f2ebccc61">

Once you open this app, you will see all the screens connected to this computer, and you can modify their EDID information here. From my computer, I have AUO9996, which is B173ZAN06.6, and AUOB394, which is B156ZAN05.1.

<img width="883" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/747a4ea0-7800-4191-bcf8-f2184a3ca369">

Take AUOB394 (B156ZAN05.1) as an example. Add 4k@120hz refresh rate information into the extension blocks of the EDID information by following the route in my screenshot. There are several ways to know the exact refresh rate parameters to set up this information. First, these EDID files usually present the 4k@60hz refresh information; just copy it and change the refresh rate to 120hz. Second, use another computer with no compatibility issues with this screen and dump the information from that computer. Thirdly, search the screen model on Google and try to see if this screen has existing EDID files online.

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

For AUOB394 (B156ZAN05.1), I have made this file, and you can download it from here [DisplayVendorID-6af.zip](https://github.com/kingo132/a51m-r2-5700m-hackintosh/files/14399339/DisplayVendorID-6af.zip). Just unpack it and put it into that folder.

You can also use SwitchResX to modify EDID under Mac OS. Take AUOB394 as an example. Here is the configuration when using SwitchResX.

<img width="652" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/c73ac6f9-e0e8-4bfb-9f0b-7f5c6b555289">
<img width="853" alt="image" src="https://github.com/kingo132/a51m-r2-5700m-hackintosh/assets/46492291/7407ca9d-a0f1-4311-9151-7ce982c3bced">

