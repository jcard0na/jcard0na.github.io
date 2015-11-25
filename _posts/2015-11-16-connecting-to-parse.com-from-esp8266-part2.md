---
layout: post
title: Connecting to parse.com with ESP8266 - Part 2
---

Today I modified the Parse Arduino SDK to add support for esp8266.

With my changes, I am able to create parse objects from Arduino sketches quite
easily.

```c++
void basicObjectTest() {
	Serial.println("basic object operation test");
	char* objectId = new char[10];

	Serial.println("create...");
	ParseObjectCreate create;
	create.setClassName("Whisper");
	create.add("toGuardian", false);
	create.add("listened", false);
	delay(100);
	{  // -- inner scope required to reduce stack usage
		Serial.println("create.send()...");
		ParseResponse createResponse = create.send();
		strcpy(objectId, createResponse.getString("objectId"));
		Serial.printf("\nobjectId:%s\n", objectId);
		int errCode = createResponse.getErrorCode();
		assert(errCode == 0, __LINE__);
		createResponse.close();
		if (errCode == 0)
			Serial.println("PASS\n");
		else
			Serial.println("FAIL\n");
	}
}
```

And the serial output...

![parse-arduino]({{ site.baseurl }}/images/2015-11-16-parse-arduino.png)

The two most time consuming problems were:

1. The stack on the esp8266 is a mere 4K, and the Parse*Objects are quite
large, which can quickly result in a stack overflow.

2. USB alone cannot power up my esp8266 reliably.  I had to use a secondary
power supply.  When only using USB power, failures range from non-connecting to
core dumps. Fun.

