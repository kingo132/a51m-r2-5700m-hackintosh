# a51m-r2-5700m-hackintosh
Hackintosh for a51m r2 with 5700m gpu

# The specification
```
CPU Brand Name:      10900K
Video Chipset:       Intel UHD 630
Built-in Monitor:    1920x1080
Touch Pad:           I2C HID Device
Audio Adapter:       RealTek ALC215
Wireless Adapter:    Changed to BCM94352Z
Discrete:            AMD RX57000M
```

# Everything works except

* Internal display does not support brightness adjustment
  * I need original iMac20,2 ioreg and DSDT dump to work out this issue
* Trackpad not support guesture
  * May need to modify the code of voodooi2c
* Audio output will reset to headphone on every boot, and the quality of headphone output is terrible
  * May need to regenerate codec under linux
* Cardreader
  * will study later
* Haven't tested sleep function
  * Will work on this once all other problems are fixed

# How to adjust the keyboard backlight brightness under Mac os

I wrote a mac program to do this, you can test it here

https://github.com/kingo132/a51m-r2-5700m-hackintosh/blob/main/alienfx-for-mac/testapps/testapps.zip

I will post this code once it finished.

# Releated issue

* https://www.tonymacx86.com/threads/compatibility-alienware-area-51-i7-10700k-amd-radeon-tm-rx-5700m.308933/
* https://www.tonymacx86.com/threads/alienware-area51m-r2-near-fully-working-problems-with-display-and-sound.309032/
