---
layout: post
title: Driving e-ink display from kinetis freedom board
---

Last week I got an [tiny e-ink
display](http://www.aliexpress.com/item/1-54-WFC0000CZ07-partial-refresh-200x200-dots-paper-white-display-e-ink/32571690945.html)
that I thought would be ideal for my project.  I'll document here my efforts to connect it to a [Kinetis Freedom board KL43](http://www.nxp.com/products/software-and-tools/hardware-development-tools/freedom-development-boards/freedom-development-platform-for-kinetis-kl43-kl33-kl27-kl17-and-kl13-mcus:FRDM-KL43Z).

First the connection.  The board came with a breakout connector that includes
the voltage pump logic recommended by the vendor.  

This is how I connected the adapter board to the freedom board.  You will find the supporting documentation [here](https://github.com/jcard0na/e-ink-with-kinetis/tree/master/docs).

*Board pin*|  *MCU pin* | *MCU Function* | *Breakout board pin*
:-------------|:-------------:|:----------:|:-------------------|
J2-2  | PTA13 | GPIO OUT   | 4 | RESET
J2-4  | PTD2  | GPIO OUT   | 5 | D/C 
J2-6  | PTD4  | SSPI1 SS   | 6 | CS1 
J2-8  | PTD6  | SPI1 MOSI  | 8 | SDI 
J2-10 | PTD7  | SPI1 MISO  | N/C | - 
J2-12 | PTD5  | SPI1 CLK   | 7 | SCLK 
J2-14 | GND   |     -      | 18 | GND 
J2-16 | N/C   |     -      | - | Reset
J2-18 | PTE0  | GPIO IN    | 3 | BUSY
J2-20 | PTE1   |     -      | - | -
J3-3  | V3.3  |     -      | 16 | V3.3

Also, short BS1 to ground on the adapter, by shorting positions 1 with 17 on
the jumper.  This will select the more efficient 4-wire spi interface.
Alternatively you could use PTE1 (J2-20) to make that option selectable.

On to coding.
