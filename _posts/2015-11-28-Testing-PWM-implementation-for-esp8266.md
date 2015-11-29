---
layout: post
title: Testing PWM implementation for esp8266
---

Just a quick entry to document my testing of 
[this PWM](https://github.com/SuperHouse/esp-open-rtos/pull/72) library for the open esp8266 sdk.

The api is very simple:

```c
/* Very basic example to test the pwm library
 * Hook up an LED to pin14 and you should see the intensity change
 */
#include "espressif/esp_common.h"
#include "esp/uart.h"
#include "FreeRTOS.h"
#include "task.h"
#include "pwm.h"

void task1(void *pvParameters)
{
    printf("Hello from task1!\r\n");
    // XXX: duty cycle of zero crashes for me.  skip for now
    uint32_t const init_count = UINT16_MAX/16;
    uint32_t count = init_count;
    while(1) {
        vTaskDelay(100);
        printf("duty cycle set to %d/UINT16_MAX%%\r\n", count);
        pwm_set_duty(count);
        count += UINT16_MAX/16;
        if (count > UINT16_MAX)
            count = init_count;
    }
}

void user_init(void)
{
    uint8_t pins[1];
    uart_set_baud(0, 115200);

    printf("SDK version:%s\n", sdk_system_get_sdk_version());

    printf("pwm_init(1, [14])\n");
    pins[0] = 14;
    pwm_init(1, pins);

    printf("pwm_set_freq(1000)     # 1 kHz\n");
    pwm_set_freq(1000);

    printf("pwm_set_duty(UINT16_MAX/2)     # 50%%\n");
    pwm_set_duty(UINT16_MAX/2);

    printf("pwm_start()\n");
    pwm_start();

    xTaskCreate(task1, (signed char *)"tsk1", 256, NULL, 2, NULL);
}
```

And two snapshots from GPIO14 taken with the logic analyzer while the above
test was running.

6.25% duty cycle           |  68.65% duty cycle
:-------------------------:|:----------------------------------:
![]({{ site.baseurl }}/images/6.25duty.png) | ![]({{ site.baseurl }}/images/68.65duty.png)

### Issues

1. The library crashes when the duty cycle is set to 0 (```pwm_set_duty(0)```).
   It is probably a problem with the underlying timers, but I would suggest
   detecting that in the ```pwm_set_duty()``` function and just call pwm_stop().
2. When setting the duty cycle to 100%, the output is not truly 100% (i.e. constant high) but rather 99.65%
   I would also suggest to detect that scenario in ```pwm_set_duty()``` and set the output
   to constant high.
3. The library/target does not work at high frequencies. When setting the
   frequency to 50kHz the observed output is 40kHz.
4. Every change of duty cycle resets the output to HIGH.  This might introduce
   glitches in applications where the duty cycle changes frequently (e.g. audio)

![]({{ site.baseurl }}/images/99.65duty.png)


