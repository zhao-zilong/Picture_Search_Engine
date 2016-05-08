#!/bin/bash

for var in "$@"
do
./colorDescriptor --descriptor sift $var --output sample.sift
done
sed -n '4,$p' sample.sift | tr -d ";" | sed 's/<CIRCLE [1-9].*> //' > trav.sift
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
/usr/local/bin/R --slave --no-save --no-restore --no-environ --args centers256.txt 256 trav.sift res1nn.txt < 1nn.R
perl histogram_sift.pl res1nn.txt > first_analyse
