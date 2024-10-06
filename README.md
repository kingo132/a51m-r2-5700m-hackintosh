
[![](https://img.shields.io/badge/Chat-Alienware%20Hackintosh-critical)](https://gitter.im/Alienware-hackintosh/community)

⚠️ DO NOT UPGRADE TO SONOMA. IT WILL BREAK THE WIFI.

* First of all, iMac 20,1 is not supported to use the root patch of Opencore Legacy Patcher. Therefore, the popular workaround on the internet does not work for this model. [OCLP Supported Models](https://dortania.github.io/OpenCore-Legacy-Patcher/MODELS.html)
* Sonoma 1st beta supports only the following Broadcom chipsets: 14e4:43dc, 14e4:4464, 14e4:4488, 14e4:4425, 14e4:4433 and 14e4:4434, i.e. BCM4355 (802.11ac), BCM4364 (802.11ac), BCM4377b (802.11ac), BCM4378 (802.11ax), BCM4387 (802.11ax) and BCM4388 (802.11ax). Afaik, all those are provided as specific SOCs to Apple by Broadcom, i.e. chips to be soldered on Apple motherboards and not available on add-on mini-PCIe/M.2 cards.
* https://wikidevi.wi-cat.ru/Broadcom
* With regards to the wireless chipsets fitted to Intel Mac platforms supported by Sonoma, it's as follows:
  * 2018 Mac mini8,1 -> BCM4364 (pci14e4,4464)
  * 2018/2019 MacBookAir8,x -> BCM4355 (pci14e4,43dc)
  * 2020 MacBookAir9,1 -> BCM4377b (pci14e4,4488)
  * 2018/2019 MacBookPro15,x -> BCM4364 (pci14e4,4464)
  * 2019/2020 MacBookPro16,x -> BCM4364 (pci14e4,4464)
  * 2019 iMac19,x -> BCM4364 (pci14e4,4464)
  * 2020 iMac20,x -> BCM4364 (pci14e4,4464)
  * 2017 iMacPro1,1 -> BCM4355 (pci14e4,43dc)
  * 2019 MacPro7,1 -> BCM4364 (pci14e4,4464)
* Hope someone can make some kind of adapter to convert those soldered WiFi modules to the M.2/NGFF interface.
  
Reference: https://www.insanelymac.com/forum/topic/357087-macos-sonoma-wireless-issues-discussion/?do=findComment&comment=2807454

# ChangeLog

### 20241006
This update mainly reduced power consumption and idle temperatures, which significantly helped with the heat issue on the left palm rest, making it more comfortable to type on the built-in keyboard.
1. I added CPUFriend.kext and CPUFriendDataProvider.kext to enable the 800MHz speed step for my 10900K CPU; previously, the lowest speed was 1200MHz. This reduced the CPU's idle power consumption from 10 watts to as low as 5 watts, and brought the idle temperature down from 55°C to 45°C.
2. I also found that the 4K 120Hz refresh rate of the built-in monitor was putting significant strain on the AMD RX5700m GPU, causing it to run at its maximum memory clock speed of 1400MHz, which led to an idle power consumption of 30 watts. When I set the refresh rate to 4K 60Hz, the memory clock dropped to a normal idle speed of around 50MHz, lowering the power consumption to just 10 watts. This reduced the GPU's idle temperature from 55°C to 45°C.

After these two adjustments, the overall idle temperature of the system dropped from 55°C to 45°C, and the built-in battery now lasts about 2 hours under very light usage.
![QQ_1728231885842](https://github.com/user-attachments/assets/87567166-3bbb-45e5-b22b-f5e16dcd3ba6)

### 20230401
1. Fixed the backlight problem for Mac OS 13.3 Ventura

### 20221025
1. Support the backlight adjustment for Mac OS 13.0 Ventura

### 20220818
Greetings everyone. This changelog is a piece of good news. However, this has nothing to do with software.

I just changed my built-in display from B173ZAN06.1 to B173ZAN06.6. This 06.6 is a 4K@120hz Mini-LED display with 737 nits brightness (1000 nits peak), compared to 06.1 which has 480 nits (peak unknown). It has all the merits of 06.1 despite a bit gray in saturation in my experience (maybe no or tiny difference, just my perception). The most important is it is Mini-LED, which will have great black color and HDR support. I've tested several HDR videos on Mac OS. I have to say the experience is nearly as good as the display of a MacBook Pro 14inch 2021, which has 1000 nits (1600 nits peak) brightness. When compared to this MacBook Pro, the MacBook Pro does a little brighter and higher in contrast than 06.6, but the difference is not that much. So, in my opinion, this display is nearly 80% percent great when compared to the XDR display in MacBook Pro.

However, this 06.6 display has a problem in Windows. The AMD driver can not automatically recognize it well. By default, the AMD driver will crash after it detects this display. There are a few steps needed to adjust to using this display in Windows. First, you need to close the lid and use an external monitor, and then use this tool [Custom Resolution Utility](https://www.monitortests.com/forum/Thread-Custom-Resolution-Utility-CRU) to change the resolution information of this display in EDID in the registry. If you need detailed instructions, I will post them later.

Plus, this 06.6 display uses 0.5mm gap 40 pin connector.

### 20220808
Great thanks to [@TechProgenitor](https://github.com/TechProgenitor). This Hackintosh is incredibly perfect now after his modification and advice.
1. Fixed trackpad guesture problem.
2. Fixed all the sound card related problem.

### 20220726
1. Fixed Lid sleep/wake and Battery indicator problem. By switching SSDT-EC-USBX-DESKTOP.aml to SSDT-EC-USBX-LAPTOP.aml.
2. Added boot chime of a Windows ME/2000 boot sound, which is my favorite.

### 20220724
1. Fixed sleep/wake related issues. The built-in display wake black issue seems fixed, by SSDT-AOACWAKE.aml.

### 20220710
1. Fixed sleep/wake issue. However, the built-in display will wake with black screen after a long sleep (maybe 10+ hours). Other components seem fine after the wake, and I can hear the system sound while typing on my keyboard. This black screen problem can not be recovered. The only choice is to do a force reboot. I have tried several ways to fix it but with no success.

### 20220705
You can upgrade to Monterey now. You may, however, encounter failure during the second step of the OTA updating process with a boot error "ocb: starting image failed". Maybe it is due to the Secure boot option or the configuration of this EFI. I don't know the exact reason, and I just circumvent it by using another 10900k EFI and then switching back to my one. So be careful if you are using OTA to update to the Monterey. Anyway, fresh install Monterey looks fine.
1. Added rx5700m GPU temperature sensor for iStat Menus
2. Fixed Monterey backlight patch for rx5700m
3. Updated Opencore to 0.8.2

# a51m-r2-5700m-hackintosh
Hackintosh for alienware area 51m r2 with 5700m gpu, support Bigsur & Monterey

# The specification
```
CPU Brand Name:      10900K
Video Chipset:       Intel UHD 630
Built-in Monitor:    1920x1080@144hz, changed to B173ZAN06.1 (4k@120hz)
Touch Pad:           I2C HID Device
Audio Adapter:       RealTek ALC215
Wireless Adapter:    Changed to BCM94352Z
DGPU:                AMD RX57000M
Card Reader:         Realtek RTS5260 PCI-E Card Reader, 10EC:5260, 1028:099B
```

# Everything works except

- [x] Internal display does not support brightness adjustment
  * fixed! See my modified version of Whatevergreen for more detail: https://github.com/acidanthera/WhateverGreen/pull/90
- [x] Geekbench 5 Metal score only get 20000 under mac os, which compared to Windows 10 will get 50000
  * fixed! Modify the vBIOS using this tool ([RED BIOS EDITOR](https://www.igorslab.de/en/red-bios-editor-and-morepowertool-adjust-and-optimize-your-vbios-and-even-more-stable-overclocking-navi-unlimited/3/)) and use that vBIOS to add ATY,bin_image property. See [Unlock the performace of rx5700m in MacOS section](#unlock-the-performace-of-rx5700m-in-macos)
- [x] Trackpad not support guesture
  * ~~May need to modify the code of voodooi2c, too difficult for me to fix.~~
  * Fixed! Thanks to [@TechProgenitor](https://github.com/TechProgenitor) for providing the information. https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/6
- [x] Audio output will reset to headphone on every boot, and the quality of headphone output is terrible
  * ~~Fixed. Swaped the positions of the headphone and speaker in pin config data, then when mac os auto select headphone, it is speaker. And use this kind of adapter to connect you headphone.~~
  * Fixed. Thanks to @TechProgenitor for providing the information. https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/8 .
  If you want to eliminate the distortion of the headphone, you can execute these commands.
```
alc-verb 0x19 SET_PIN_WIDGET_CONTROL 0x20
alc-verb 0x21 SET_EAPD_BTLENABLE 0x0
alc-verb 0x21 SET_EAPD_BTLENABLE 0x2
```
  Besides, if you want to use your microphone in your headphone, you still need this kind of adapter below because there are two audio ports in this machine.
  
  ![image](https://user-images.githubusercontent.com/46492291/136552568-8a17c49b-2185-47d0-b085-ef00d7c1b2a4.png)
- [x] Cardreader
  * Fixed! Use this driver: https://github.com/0xFireWolf/RealtekCardReader
- [ ] Thunderbolt hotplug
  * Haven't tested: https://github.com/RockJesus/macOS-IOElectrify
- [x] Sleep / Wake
  * ~~Sleep will crash with "Sleep Wake failure in EFI" error. Seems not easy to fix.~~
  * Fixed! First, you need to disable "Firmware TPM" in BIOS to prevent "Sleep Wake failure in EFI" panic. Then, I placed SSDT-GPRW.aml in EFI to fix the instant wakeup problem. Currently, everything looks fine after sleep and waking up.
  * Remember to set these pmset options to prevent other sleep problems. (Sugesstions come from [Opencore Sleep Guide](https://dortania.github.io/OpenCore-Post-Install/universal/sleep.html#preparations))
```
sudo pmset autopoweroff 0
sudo pmset powernap 0
sudo pmset standby 0
sudo pmset proximitywake 0
sudo pmset tcpkeepalive 0
```
- [x] Eye tracking
  * Won't work.

# AlienFX for Mac

I wrote a mac program to adjust the keyboard backlight brightness under Mac os, you can test it here

https://github.com/kingo132/AlienFX-For-MacOS

# Unlock the performace of rx5700m in MacOS

By default, this rx5700m can only get 20000 Geekbench Metal score in MacOS, compared to Windows it can get 50000+ score. Here is the step to unlock it's performance. No need to modify any thing. Just resave the vBIOS using RED BIOS EDITOR tool. After the modification, the score will be 60000, enough for the performance of this rx5700m under MacOS.

1. Dump the original vBIOS using a tool called amdvbflash.exe, save it to a51m.orig.rom.
2. Download the RED BIOS EDITOR tools here: https://www.igorslab.de/en/red-bios-editor-and-morepowertool-adjust-and-optimize-your-vbios-and-even-more-stable-overclocking-navi-unlimited/3/
3. Run MorePowerTool, open a51m.orig.rom, click save to save a mpt file a51m.orig.mpt
4. Run Red BIOS Editor, open a51m.orig.rom, then load a51m.orig.mpt, then save to a51m.resave.rom
5. run command "head -c 65536 a51m.resave.rom > a51m.resave.rom.64k" to get the first 64k of the rom
6. run command "xxd -p a51m.resave.rom.64k | tr -d '\n' > a51m.resave.rom.64k.txt" to get the txt of the hex value of this 64k rom
7. open a51m.resave.rom.64k.txt, copy all the content to ATY,bin_image

![image](https://user-images.githubusercontent.com/46492291/135756058-862ded94-3ab1-4f23-af80-e03ec185085d.png)

Here is the binary comparation of the original vBIOS rom and the resaved vBIOS rom.

![image](https://user-images.githubusercontent.com/46492291/135636806-20596fd7-f66b-4ea6-8cdc-1a2807e9f9a4.png)

As you can see, although we didn't modify anything when resave the vBIOS file using RED BIOS EDITOR, it still has some modifications. I don't know what it modified, if you know, please tell me. And anyway, the performance is unlocked.

# Replace the built-in display to 4k@120hz

I replaced the built-in display to B173ZAN06.1, which is 4k@120hz. And the stock dp cable (DC02C00JU00, 0.5mm gap 40 pin connector) is not compatible. It needs to be changed to DC02C00MY00, which has a 0.4mm gap 40 pin connector.

And there's another panel, B173ZAN06.0, which is 4k@60hz, is capatible with the stock dp cable. There's no need to buy a new cable if you change to this panel.

And there's some small issue with B173ZAN06.1.
* First, the newest AMD driver will giltch in windows 10, you have to use the AMD driver come with dell which is an old version that can be downloaded in dell website.
* Second, in mac os it can only get 4k@60.03hz, I don't know the reason, may be need to patch Apple AMD driver. (Fixed, see [HERE](https://github.com/kingo132/a51m-r2-5700m-hackintosh/blob/main/fix_navi10_4k_120hz.md) for more detail.)

# Releated issue

* https://www.tonymacx86.com/threads/compatibility-alienware-area-51-i7-10700k-amd-radeon-tm-rx-5700m.308933/
* https://www.tonymacx86.com/threads/alienware-area51m-r2-near-fully-working-problems-with-display-and-sound.309032/
* https://www.reddit.com/r/hackintosh/comments/onqr4r/alienware_area_51_r2_with_rx_5700m_works_on_big/
* https://www.reddit.com/r/hackintosh/comments/af646k/alienware_area_51m_as_hackintosh_laptop/
* https://www.reddit.com/r/hackintosh/comments/oml3un/alienware_area_51m_r2_with_rx_5700m_compatible/
