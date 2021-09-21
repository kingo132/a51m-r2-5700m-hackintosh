
[![](https://img.shields.io/badge/Chat-Alienware%20Hackintosh-critical)](https://gitter.im/Alienware-hackintosh/community)

# a51m-r2-5700m-hackintosh
Hackintosh for alienware area 51m r2 with 5700m gpu, currently I'm running Big Sur 11.5.2

# The specification
```
CPU Brand Name:      10900K
Video Chipset:       Intel UHD 630
Built-in Monitor:    1920x1080@144hz, I changed it into B173ZAN06.1 (4k@120hz)
Touch Pad:           I2C HID Device
Audio Adapter:       RealTek ALC215
Wireless Adapter:    Changed to BCM94352Z
DGPU:                AMD RX57000M
Card Reader:         Realtek RTS5260 PCI-E Card Reader, 10EC:5260, 1028:099B
```

# Everything works except

* Internal display does not support brightness adjustment
  * fixed! Only warm boot from Windows will work, cold boot won't work. See my modified version of Whatevergreen for more detail: https://github.com/acidanthera/WhateverGreen/pull/90
* Geekbench 5 Metal score only get 20000 under mac os, which compared to Windows 10 will get 50000
  * fixed! Modify the vBIOS using this guid ([Chinese Only](https://ngabbs.com/read.php?tid=23329199&rand=624)) and use that vBIOS to add ATY,bin_image property. Or you can just uncomment that property in my opencore config file to let it take effect. (Disabled by default for safty reason, because haven't done much test and I can't read GPU temperature under MacOS.)
* Trackpad not support guesture
  * May need to modify the code of voodooi2c, too difficult for me to fix.
* Audio output will reset to headphone on every boot, and the quality of headphone output is terrible
  * Too difficult for me to fix, may need a lot of time to modify the code of AppleALC
* Cardreader
  * Fixed! Use this driver: https://github.com/0xFireWolf/RealtekCardReader
* Sleep / Wake
  * Seems not easy to fix.
* Eye tracking
  * Won't work.

# AlienFX for Mac

I wrote a mac program to adjust the keyboard backlight brightness under Mac os, you can test it here

https://github.com/kingo132/AlienFX-For-MacOS

# Releated issue

* https://www.tonymacx86.com/threads/compatibility-alienware-area-51-i7-10700k-amd-radeon-tm-rx-5700m.308933/
* https://www.tonymacx86.com/threads/alienware-area51m-r2-near-fully-working-problems-with-display-and-sound.309032/
* https://www.reddit.com/r/hackintosh/comments/onqr4r/alienware_area_51_r2_with_rx_5700m_works_on_big/
* https://www.reddit.com/r/hackintosh/comments/af646k/alienware_area_51m_as_hackintosh_laptop/
* https://www.reddit.com/r/hackintosh/comments/oml3un/alienware_area_51m_r2_with_rx_5700m_compatible/

# Some information
* ~~The intergrated Intel graphic card can only work with the typec monitor. Currently not work on mac os. Refer: https://www.reddit.com/r/Alienware/comments/fl8693/area_51m_with_rtx_2060_and_optimus/~~
* ~~About MUX chip: https://dortania.github.io/GPU-Buyers-Guide/misc/discrete-laptops.html#understanding-what-discrete-laptop-gpus-work~~
