---
layout: post
title: Cloud Code from parse.com
---

Today I tried Cloud Code from Parse.  They have done a very good job to make it
really easy to run applications on the their cloud.  All I had to do is...

0. Create a subdomain for the parse application I wanted to use as backend.  
    ![]({{ site.baseurl }}/images/parse-subdomain.png)


1. Install their command line tool

	```bash
	curl -s https://www.parse.com/downloads/cloud_code/installer.sh | sudo /bin/bash
	```

2. Create a first app

	```bash
	parse new
    Would you like to create a new app, or add Cloud Code to an existing app?
    Type "(n)ew" or "(e)xisting": e
	...
	```
	Gotcha: On my first attempt I did not read this correctly and chose (n)ew.
 	This resulted on my code being deployed on a new application, different
	from the application associated with the subdomain chosen above.
	A bunch of 'Internal Server Errors' later I found the problem.

3. Create a template app using Express js framework

	```bash
	parse generate
	...
	```
4. Edit the code under ```cloud/app.js```

5. Deploy

	```bash
	parse deploy
	...
	```

Now you can create your customized APIs with minimal effort.
