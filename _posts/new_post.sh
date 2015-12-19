#! /bin/bash

[ "${1}" == "" ] && { echo "usage: $0 title-for-this-post"; exit -1; }
FILENAME=`date +'%Y-%m-%d'`-${1}.md
[ -f $FILENAME ] && exit -1

cat > $FILENAME <<HERE
---
layout: post
title: ${1//-/ }
---
HERE

exec vim $FILENAME
