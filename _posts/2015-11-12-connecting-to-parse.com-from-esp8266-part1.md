---
layout: post
title: Connecting to parse.com with ESP8266 - Part 1
---

My goal of the day is to connect an ESP8266 to parse.com

## Ingredients

1. An ESP8266 board (I used [this one](http://www.adafruit.com/product/2471))

## Preparation

1. Install the [Arduino IDE](https://www.arduino.cc/en/Main/Software) (I used version 1.6.6)
2. ```Arduino->Preferences->Additional Boards Manager URLs: http://arduino.esp8266.com/staging/package_esp8266com_index.json```

![boards-manager-image]({{ site.baseurl }}/images/2015-11-12-screenshot.png)

3. Try to run the HTTPSRequest example under ```~/Library/Arduino15/packages/esp8266/hardware/esp8266/1.6.5-1160-gef26c5f/libraries/ESP8266WiFi/examples/HTTPSRequest```
If you have a newer version of the esp8266 package (i.e. newer than
1.6.5-1160-gef26c5f), the example might work, and you can skip to the last
step.  That version did not work for me, and running the code resulted in
numerous core dumps on the serial console.  In that case, go to the next
step.

4. Clone ```git@github.com:esp8266/Arduino.git```
under your ```Arduino/hardware``` directory (i.e. the Arduino sketchbook
location you set via Arduino-&gt;Preferences). You might need to create the
hardware directory first.

5. Restart Arduino and try again running the HTTPSRequest example from step 3.  This worked for me.  The version of esp8266/Arduino.git I used is: ```git rev-parse HEAD:
3c14656a26a094ea5640a7114741193dc1505e4a

6. Change the HTTPSRequest example to connect to parse.

```diff
- const char* host = "api.github.com";
+ const char* host = "api.parse.com";
(...)
- String url = "/repos/esp8266/Arduino/commits/esp8266/status"
+ String url = "/1/classes/GameScore"
```

and run the sketch.  If you see an "unauthorized" response, that is good: you
are talking to the parse.com servers.

## References

[1](https://github.com/esp8266/Arduino/issues/43)
[2](https://github.com/esp8266/Arduino/issues/824)

