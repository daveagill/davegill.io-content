+++
title = "Installing CyanogenMod on my Samsung S3-mini"
date = "Tue, 15 Apr 2014 13:32:38 +0000"
draft = false
tags = ["Android", "Mobile", "SysAdmin"]
aliases = ["/2014/04/installing-cyanogenmod-on-my-samsung-s3-mini/"]
+++

Why did I want to install a new Android?
----------------------------------------

I've been putting up with an annoying issue on my S3-mini (GT-I8190N) for a few months now - the screen will take forever (many seconds) to wake up if the phone's been sleeping for a while. Even worse is that this will even happen when someone is ringing me!

Most people would probably deal with it, but it bugs the hell out of me and a factory reset didn't help. So I decided it would be a good opportunity to have a go at installing a different version of Android.

My phone was running with 4.1 'Jelly Bean', whereas the latest version of Android is 4.4 'KitKat', so it was worthwhile an upgrade just to see what's new in KitKat.

After a recommendation from a coworker and a few minutes of research I quickly settled on [CyanogenMod](http://www.cyanogenmod.org/ "Cyanogenmod") as my Android flavour for no reason other than it seems fairly mainstream.

Gotcha's!
---------

The first thing I discovered is that it seems that the S3-mini is a relatively obscure device in the world of rooting phones and custom Android versions...

First off, CyanogenMod is not officially supported on the S3-mini (yet it is on the regular S3, the first Galaxy mini and the S4-mini) fortunately [NovaFusion](http://novafusion.pl/s3-mini/ "NovaFusion - S3-mini") has a respectable-looking unofficial port.

Second of all I really struggled to find any a way to root the phone (and it turns out I didn't even need to!). I tried a number of techniques - all failed.  I didn't get to try this [CF Rootfile](http://www.androidveterans.com/root-galaxy-s3-mini-install-clockworkmod-recovery/ "Android Veterans") approach but that was next on my list. What did work for me was [VRoot](http://www.mgyun.com/en/getvroot "VRoot by mgyun"), a one-click rooter for Windows which worked perfectly after many other one-click rooters had failed; you just have to get over the fact it's a poorly translated version of a Chinese tool.

Only after having rooted the device did I spot that it wasn't even necessary! Closer inspection of CyanogenMod's [instructions for the regular S3](http://wiki.cyanogenmod.org/w/Install_CM_for_i9300 "Cyanogenmod Install for S3") revealed that Samsung devices come with a special 'Download Mode' (press **Power**, **Home** and **Volume Down** together) from which you can install a custom Recovery image.

'Download Mode'?
----------------

My understanding is that Samsung's 'Download Mode' is akin to Fastboot mode which could only be enabled from an unlocked bootloader, for which you would need a rooted phone. So Samsung kindly side-step all that.

Download Mode allows you to flash ODIN-compatible images (ODIN is a protocol and software package used internally by Samsung and since leaked to the wider world). Rather than using the ODIN software to perform the upload I used [Heimdall](http://glassechidna.com.au/heimdall/ "Heimdall"), as recommended by CyanogenMod's instructions.

Flashing a custom Recovery image
--------------------------------

The image we want to flash isn't Android itself, it is a custom Recovery image. From which we can perform a backup (before proceeding further) and then do the actual install of a new Android system.

The recovery image is a small image that is ordinarily used to perform factory resets and to handle the OTA updating, as well as a few other things. Booting to a recovery image first is just like when you boot to a CD-ROM, Flash-drive or hidden recovery partition first when you are installing a regular OS on a regular computer.

However, the stock recovery image that comes with most phones does not expose functionality for installing custom Android OS images, or for doing full system backups. This is why we need a custom Recovery image.

The most popular Recovery image seems to be [clockworkMod](https://www.clockworkmod.com/rommanager "clockworkmod") and that is what I used.

For the S3-mini I had to deviate from the flashing instructions given by CyanogenMod. The following command would not work:

```bash
sudo heimdall flash --RECOVERY recovery.img --no-reboot
```

I worked out that the --RECOVERY argument refers to the ID of the partition you want to flash, my recovery partition was just called "19" so I had to use this command:

```bash
sudo heimdall flash --19 recovery.img
```

A brief Googling indicated that this seemed to be true for other S3-mini users too. Nevertheless I would recommend double-checking! To list the partitions I ran this command:

```bash
heimdall print-pit --verbose
```

And then I just looked for one that referred to a recovery.img and took its ID (19).

Making a backup
---------------

Before going any further I wanted a backup of the stock Android image, so I could recover to this if CyanogenMod did not work, or if I screwed something up.

First, boot into the recovery image by pressing **Power**, **Home** and **Volume Up** together.

Within the menu there is an option for making a backup. Actually there are two options, one will put the backup on the phone, the other will but it on the external SD-Card. Obviously choose whichever has the most space available. For me that was the external SD-Card, which is probably the ideal place for it anyway.

I went as far as to copy this off the SDCard onto my PC for safe keeping.

Install CyanogenMod already!
----------------------------

Finally, time to install CyanogenMod!

The image .zip must be placed on the root of the SDCard. I used [adb](http://developer.android.com/tools/help/adb.html "Android Debug Bridge") to put it there but if you have an external (micro) SD-Card and reader then you can just drag-and-drop.

It is also important to pre-load some Google Apps, otherwise you'll have Android but no apps (no Play Store app, GMail, Chrome, etc). Luckily NovaFusion have several app-bundle options - I just went for the full zip bundle, nice and easy. Just place this zip alongside the Android image zip on the root of the SDCard.

The rest is easy. Just boot into the recovery image and there is an option to install new zip packages. Install the OS first and then the app-bundle.

Et Voila!

Final thoughts...
-----------------

The experience was relatively painless and went smoothly - no accidental bricking of my phone!

CyanogenMod works well - I have been using it for about a week now - and there haven't been any serious issues. One time I had an email syncing issue which a restart fixed, it is far from clear whether CyanogenMod actually had anything to do with that though.

Only one or two minor things do I miss from Samsung's customised Android. All of which I'm sure I could achieve using freely available apps. One of them is having a 'home' screen which is not the far-left one, the default android Launcher (Google Now) always chooses the left-most screen to be the target when you press the Home button. So far these don't bother me :-)

Best of all? _**My wakeup issue is now fixed!**_