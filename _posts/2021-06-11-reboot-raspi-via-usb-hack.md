---
layout: post
title: reboot raspi via usb hack
---

One cannot power cycle a Raspberry Pi to reboot: this corrupts the SD card and leaves the pi unbootable.
I found the hard way...

And in my current project, I had no console (serial or remote), nor access to
GPIO.  Solution, hack the USB port to make it a reset button.

## How does it work?  

Pulling down the USB Vbus line is picked up by the USB host and reported as an
error.  So I wrote a small daemon that looks for that error and shuts down the
system.

## Hardware

You can build this like this:

<img src="{{ site.baseurl }}/images/IMG_1711.JPG" width="350">

## Warranty

None.  Zero.  Specially considering that the error that we trigger is an
overcurrent notice.  The USB host does have protection against that, but it
certainly was not designed to be used this way.

## Code

[https://github.com/jcard0na/usbhalt](https://github.com/jcard0na/usbhalt)
