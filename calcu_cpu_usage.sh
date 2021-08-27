#!/usr/bin/env bash

while true; do
	cpu_usage=$(mpstat -P ALL 2 5 | grep "Average" | awk '{print $3+$4+$5+$6+$7+$8+$9+$10+$11}' | tail -n 12)
	
	sum=0
	index=0
	
	for i in $cpu_usage
	do
		echo $index:$i%
		sum=$(echo "$sum+$i" | bc)
		index=$((index + 1))
	done
	
	echo SUM:$sum%
	echo "========================"
	sleep 1200
done
# for i in $cpu_usage_list_sys
# do
# 	for j in $cpu_usage_list_soft
# 	do
# 		#sum=$(echo "$sum+$i+$j" | bc)
# 		value=$(echo "$i+$j" | bc)
# 		#echo $index: $value%
# 		#index=$((index + 1))
# 	done
# 	sum=$(echo "$sum+$value" | bc)
# 	echo $index: $value%
# 	index=$((index + 1))
# done
# 

##for i in {0..11}
##do 
##	value=$(echo "${cpu_usage_list_sys[i]}+${cpu_usage_list_soft[i]}" | bc)
##	echo $index: $value%
##	index=$((index + 1))
##	sum=$(echo "$sum+$value" | bc)
##done

##echo SUM:$sum%

