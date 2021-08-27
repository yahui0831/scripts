#!/usr/bin/env bash

dowork() {
	#./xlink_host_test 1300 $1 $2 100000 4 | tee xlink_$1_$2.log
	./xlink_host_test 1300 $1 $2 100000 4 | tee xlink_$1_$2.log

	cnt=$(grep "second" xlink_$1_$2.log | awk -F ' ' '{print $5}')
	echo CNT:$cnt
	sum=0
	for i in $cnt;do
		echo $i		
		sum=$(echo "$sum+$i" | bc)
	done

	echo sum:$sum
}

sum=0
for i in range 2; do
	_sum=$(dowork $1 $2) 
	sum=$(echo "$sum+$_sum" | bc)
	echo summary:$sum
	sleep 10
done

avg=$(echo "$sum/2" | bc -l)
echo AVG:$avg
