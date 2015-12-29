---
layout: post
title: Lightsaber sounds with JQ6500
---

Today I received the JQ6500-16p modules that I had [ordered last week](http://www.ebay.com/itm/161790695060).  
There is a lot of good info on these modules on the net.  [This
repo](https://github.com/sleemanj/JQ6500_Serial) was specially useful, as I
intend to drive the module from an Arduino microcontroller.  

What I could not find is any documentation on how to upload files to the board
if one does not have a Windows system.  I could not do this natively on Linux,
or even with Wine, but I was able to use a Windows virtual machine.

The steps I followed below:

1. Fire up a Windows OS Virtual Machine (Windows 8.1 Eval Version on Virtual Box)
2. Attach the JQ6500 via USB
3. On the VirtualBox menu, select Devices -> USB Devices -> CD002.  This makes the module available to windows
4. A new CD drive will show up in the file explorer.
5. Execute the program 'MusicDownload' that you will find on that drive.
6. It is all in Chinese, but first select the second tab, and pick your MP3 files.  Then select the first tab to upload them.  
  ![]({{ site.baseurl }}/images/jq6500-done.png)
7. Now wire it up, and test.  The [datasheet]({{ site.baseurl }}/images/JQ6500%20voice%20Module.pdf) was very useful.

<script src="http://vjs.zencdn.net/5.4.4/video.js"></script>

<div>
<video id="jq6500" class="video-js vjs-default-skin" controls preload="auto" width="320" height="240" poster="{{ site.baseurl }}/images/jq6500.jpg" data-setup="{}">
<source src="{{ site.baseurl }}/images/jq6500.mp4" type='video/mp4'>
</video>
</div>
