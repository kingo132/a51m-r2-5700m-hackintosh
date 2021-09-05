
[![](https://img.shields.io/badge/Chat-Alienware%20Hackintosh-critical)](https://gitter.im/Alienware-hackintosh/community)

# a51m-r2-5700m-hackintosh
Hackintosh for alienware area 51m r2 with 5700m gpu, currently I'm running Big Sur 11.5.2

# The specification
```
CPU Brand Name:      10900K
Video Chipset:       Intel UHD 630
Built-in Monitor:    1920x1080@144hz
Touch Pad:           I2C HID Device
Audio Adapter:       RealTek ALC215
Wireless Adapter:    Changed to BCM94352Z
DGPU:                AMD RX57000M
```

# Everything works except

* Internal display does not support brightness adjustment
  * fixed! (with some hacking method, may have some potential problem, haven't done much test.). See my modified version of Whatevergreen for more detail: https://github.com/kingo132/WhateverGreen
* Geekbench 5 Metal score only get 20000 under mac os, which compared to Windows 10 will get 50000
  * fixed!
* Trackpad not support guesture
  * May need to modify the code of voodooi2c
* Audio output will reset to headphone on every boot, and the quality of headphone output is terrible
  * May need to regenerate codec under linux
* Cardreader
  * will study later
* Haven't tested sleep function
  * Will work on this once all other problems are fixed

# AlienFX for Mac

I wrote a mac program to adjust the keyboard backlight brightness under Mac os, you can test it here

https://github.com/kingo132/a51m-r2-5700m-hackintosh/blob/main/alienfx-for-mac/testapps/testapps.zip

I will post this code once it finished.

# Releated issue

* https://www.tonymacx86.com/threads/compatibility-alienware-area-51-i7-10700k-amd-radeon-tm-rx-5700m.308933/
* https://www.tonymacx86.com/threads/alienware-area51m-r2-near-fully-working-problems-with-display-and-sound.309032/
* https://www.reddit.com/r/hackintosh/comments/onqr4r/alienware_area_51_r2_with_rx_5700m_works_on_big/
* https://www.reddit.com/r/hackintosh/comments/af646k/alienware_area_51m_as_hackintosh_laptop/
* https://www.reddit.com/r/hackintosh/comments/oml3un/alienware_area_51m_r2_with_rx_5700m_compatible/

# Some information
* The intergrated Intel graphic card can only work with the typec monitor. Currently not work on mac os. Refer: https://www.reddit.com/r/Alienware/comments/fl8693/area_51m_with_rtx_2060_and_optimus/
* About MUX chip: https://dortania.github.io/GPU-Buyers-Guide/misc/discrete-laptops.html#understanding-what-discrete-laptop-gpus-work
