---
layout: post
title: mangoh WP to Arduino serial reroute
---

The [mangoh dev platform](http://mangoh.io) has an Arduino Leonardo connected
to a WP module.  The default configuration has the two connected via
WP:USB-FTDI-Arduino:UART.  I wanted to connect UART-to-UART, and these are the
steps to do that.

1. There is an analog switch that needs to be rerouted.

!()[{{ site.baseurl }}/images/wp-mangoh-sch1.png]

2. The FTDI chip needs to be tri-stated to avoid pulling up the RX line

!()[{{ site.baseurl }}/images/wp-mangoh-sch2.png]

3. On the WP shell, which is accessible via the on-board DB-9 serial connector or via ethernet[<sup>1</sup>][1], you need to enable the uart.

```
microcon /dev/ttyAT
AT!MAPUART=17,1
OK
```

And you are done.  To test...

4. Write a character echo program such as:

echo_data.sh:
```bash
#! /bin/sh

stty -F /dev/ttyHSL0 115200
stty -F /dev/ttyHSL0 -echo

while read X
do
    echo Got: $X, echoing back $X
    echo $X > /dev/ttyHSL0
done < /dev/ttyHSL0
```

and execute

./echo_data.sh

5. And program the Arduino to bridge the USB serial consosole to the UART port

```c
void setup() {
  Serial1.begin(115200);
}

void loop() {
  char oneChar;
  
  while (Serial.available() > 0) {
                // read the incoming byte:
                oneChar = Serial.read();
                Serial1.print(oneChar);
  }
    
  while (Serial1.available() > 0) {
                // read the incoming byte:
                oneChar = Serial1.read();

                // print locally what you got
                Serial.print(oneChar);
  }
  delay(1000);
}
```

6. Now fire up the Arduino terminal and you should see characters echoed back to you.

!()[mangoh-arduino.png]

