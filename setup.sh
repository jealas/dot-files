#!/usr/bin/env bash

me=`basename "$0"`

for i in $( ls -a -I. -I.. -I$me -I.git );
do
    rm -f ~/$i
    cp ./$i ~/$i
done
