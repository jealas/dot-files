#!/usr/bin/env bash

for i in $( ls -a -I. -I.. -Imake_sym_links.sh -I.git );
do
    rm -f ~/$i
    cp ./$i ~/$i
done
