#!/bin/sh

for f in /Users/zhaozilong/Documents/s8/ri/tp_media/sift/*.sift
do
  echo "Traitrement de $f"
  sed -n '4,$p' $f | tr -d ";" | sed 's/<CIRCLE [1-9].*> //' > ./trav.sift
  R --slave --no-save --no-restore --no-environ --args centers256.txt 256 ./trav.sift ./mapping/`basename $f` < 1nn.R
done

\rm -f ./trav.sift
