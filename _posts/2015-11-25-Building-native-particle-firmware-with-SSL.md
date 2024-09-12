---
layout: post
title: Building native particle firmware with SSL
---

I wanted to check out the [new ssl
library](https://github.com/glowfishAPI/httpsclient-particle) for particle.io's
photon. 

Steps to do that:

1. Check [the dependencies](https://github.com/spark/firmware/blob/develop/docs/dependencies.md)
2. Get and build the native firmware

    ```bash
    git clone git@github.com:spark/firmware.git particle-firmware
    cd particle-firmware/modules
    git checkout develop

    # put the photon in DFU mode by by holding down the mode/setup button on the
    #device and then tapping on the RESET button once. Release the MODE/setup button
    #after you start to see the RGB LED flashing in yellow.

    PARTICLE_DEVELOP=1 make clean all PLATFORM=photon -s program-dfu
    ```

3. Clone the httpsclient in your development folder

    ```bash
    git clone git@github.com:glowfishAPI/httpsclient-particle.git
    cd httpclient-particle
    cp -r firmware/* ../particle-firmware/user/src/
    cd ../particle-firmware/user/src/
    cp examples/timeapi-test.cpp .
    sed -i -e 's/httpsclient-particle\/httpsclient-particle.h/httpsclient-particle.h/' timeapi-test.cpp
    rm -fr examples
    rm application.cpp
    cd ../../modules
    PARTICLE_DEVELOP=1 make PLATFORM=photon -s program-dfu
    ```

4. Watch your console

    ```http 
    screen /dev/tty.usbmodem1234 9600
    ytes sent Successfully?!: 91
    matrixSslSentData: 5
    GET /utc/now/ HTTP/1.0
    User-Agent: MatrixSSL/3.7.2-OPEN
    Host: www.timeapi.org
    Accept: */*
    Content-Type: applcation/json
    Content-Length: 0

    0
    Bytes sent Successfully?!: 213
    matrixSslSentData: 0
    Sent Successfully?!, everything good
    matrixSslGetReadbuf: 1500
    HttpClient>     Done before full len
    0
    HttpClient>     Done before full len
    410
    Received: 410
    matrixSslReceivedData: Tx: 410 Len: 272 rc: 4
    HTTP/1.1 200 OK
    Date: Thu, 26 Nov 2015 05:44:12 GMT
    Connection: close
    X-Frame-Options: sameorigin
    X-Xss-Protection: 1; mode=block
    Content-Type: text/html;charset=utf-8
    Content-Length: 25
    Server: thin 1.5.0 codename Knife
    Via: 1.1 vegur
    ```

## Gotchas

If forgot that for each now photon you need to configure your network
credentials using your host. The steps are documented [here](https://docs.particle.io/guide/getting-started/connect/photon/)
I could not find how to give it a default network credentials  at compile/flash time.
