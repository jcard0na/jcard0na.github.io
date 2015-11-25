#! /bin/bash

for i in `seq 10`
do
	FILENAME=`date +'%Y-%m-%d'`-${i}.md
	[ -f $FILENAME ] && continue
	[ $i -eq 10 ] && exit -1
	break
done

cat > $FILENAME <<HERE
---
layout: post
title: 
---
HERE

exec vim $FILENAME
