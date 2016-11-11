---
layout: post
title: Recover from kinetis in secured state
---

When using openocd and kinetis-FRDM board as debugger, you might encounter this
error when trying to reset your target:

    *********** ATTENTION! ATTENTION! ATTENTION! ATTENTION! **********
    ****                                                          ****
    **** Your Kinetis MCU is in secured state, which means that,  ****
    **** with exception for very basic communication, JTAG/SWD    ****
    ...

This could be caused by a botched image running on the on-board target triggers
a watchdog and asserts the reset line.  In my K22 board this is visible also
because the reset line is connected to an LED. 

In order to fix, you need to halt the target before entering the reset state
and flash it with a good image.

You can do this as follows:

0. If you openocd is [launched on usb hotplub by systemd](https://blog.kylemanna.com/hardware/start-openocd-on-usb-hotplug/), disable it.

    systemctl --user disable openocd-cmsis-dap.service

1. Attach the USB cable to the OpenSDA USB port.

2. Open a `telnet` session to openocd and issue the following commands

    > reset_config srst_only
    srst_only separate srst_nogate srst_open_drain connect_deassert_srst
    
    > reset halt                                  
    *********** ATTENTION! ATTENTION! ATTENTION! ATTENTION! **********
    ****                                                          ****
    **** Your Kinetis MCU is in secured state, which means that,  ****
    **** with exception for very basic communication, JTAG/SWD    ****
    **** interface will NOT work. In order to restore its         ****
    **** functionality please issue 'kinetis mdm mass_erase'      ****
    **** command, power cycle the MCU and restart OpenOCD.        ****
    ****                                                          ****
    *********** ATTENTION! ATTENTION! ATTENTION! ATTENTION! **********
    target state: halted
    target halted due to debug-request, current mode: Thread 
    xPSR: 0x01000000 pc: 0xfffffffe msp: 0xfffffffc
    
    > kinetis mdm mass_erase

3. Now you should be able to flash a new image on your target 
    arm-none-eabi-gdb --batch --ex 'target remote localhost:3333' -ex 'load freertos.elf'

Big thanks to [Kyle](https://blog.kylemanna.com) for his help on this!
