#!/usr/bin/env bash

#count=$1
#rm -rf log_*.txt
FILE_DIR=$1

for f in $(ls $FILE_DIR/*.json); do
	fn=$(basename $f .json)
    	./V2X -c $f 2>&1 | tee log_$fn.txt &
done

wait

# grep -nr "^Overall: " log_*.txt
# grep -nr "^Overall: " log_*.txt | wc -l
# grep -nr "^Overall: " log_*.txt | cut -d" " -f 8| awk 'BEGIN{c=0}{c+=$1}END{print c}'
# find . -name "jpegenc*" |xargs rm -rf "jpegenc"

