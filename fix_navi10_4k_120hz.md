# Fix AMD Radeon RX 5000 series deriver 4k@120hz problem

I replaced the built-in screen from B173HAN04.4 which is 1080p@144hz to B173ZAN06.1 which is 4k@120hz. 

The stock eDP cable which is DC02C00JU00 and has an 0.5mm gap 40 pin connector should be replaced to DC02C00MY00 which has an 0.4mm gap 40 pin connector.

![image](https://user-images.githubusercontent.com/46492291/135754338-5a6ef076-86ee-4b54-ab77-81ab14a8185e.png)

By default, only 4k@60.03hz refresh rate can be set with this B173ZAN06.1 panel under MacOS.

![image](https://user-images.githubusercontent.com/46492291/135754490-22d9b18c-6ac0-4e26-92a2-4b44e159a62e.png)

This is the EDID information of this panel.

![image](https://user-images.githubusercontent.com/46492291/135754567-2ea339ae-d9af-4456-95b0-b9832c47170e.png)
![image](https://user-images.githubusercontent.com/46492291/135754568-7ea574c8-ed63-44bd-80d6-b3841316da2c.png)

# Patch the AMD Navi10 driver

After I studied the AMD driver kext AMDRadeonX6000Framebuffer.kext, I found there is a function AmdDalServices::validateDetailedTiming will return 3758097095 which is 0xE00002C7 when set 4k@120hz refresh rate (pixel clock is 1073610000, 1073.61 MHz). It means kIOReturnUnsupported in IOReturn.h.

![image](https://user-images.githubusercontent.com/46492291/135754667-093f263b-c447-4ecd-84f7-8e0d6e1a6c07.png)

I patched this function to let it return true. Then the panel can run 4k@120hz witout problem. So the problem should lie in this function.

![image](https://user-images.githubusercontent.com/46492291/135754934-62fe2815-6b17-49c8-a365-c8791a6fe4db.png)

As you can see in the pseudocode of his function, it will call dc_validate_stream, and if the return value is not 1, it will return that kIOReturnUnsupported error. I checked this dc_validate_stream function in the AMD driver code of Linux kernel source.

![image](https://user-images.githubusercontent.com/46492291/135755030-37388032-6d91-4dee-b923-c1664fea3bcc.png)

It will call dc_link_validate_mode_timing, and then call dp_validate_mode_timing

![image](https://user-images.githubusercontent.com/46492291/135755071-a2b31a92-1ff8-4a28-ab6c-785a861976cf.png)

And inside dp_validate_mode_timing function it will call dc_link_bandwidth_kbps to get the max link bandwith.

![image](https://user-images.githubusercontent.com/46492291/135755107-74fa700d-4ae0-4973-ac9a-c900e085f4ee.png)

If the link bandwidth set by 120hz refresh rate exceed this bandwidth, it will fail. As you can see in the first screenshot, the bandwidth of 4k@120hz is 25766640. And the default return value of dc_link_bandwidth_kbps is 25142400. This will definitely fail.

![image](https://user-images.githubusercontent.com/46492291/135755505-a2435eda-f915-4535-a448-5b02e742886e.png)

After I studied this dc_link_bandwidth_kbps function, I found it may return two kinds of value. The first is 25920000 if fec is not enabled, and the second is 25142400 if fec should be enabled. Apparently, the second value will not support 4k@120hz. So I just patched this function using WhatEvergreen and let it always return 25920000. The patch code is something like this.

![image](https://user-images.githubusercontent.com/46492291/135755695-8b1257b3-b5c1-43cd-8cf6-c7fbe255d6ab.png)

Now I can turn on the 4k@120hz mode of this B173ZAN06.1 screen under MacOS.

![image](https://user-images.githubusercontent.com/46492291/135755730-96d8181c-5b25-42e8-8816-92e865876988.png)

