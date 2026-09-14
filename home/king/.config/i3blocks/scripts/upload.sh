#!/bin/bash

tx_path="/sys/class/net/wlp4s0/statistics/tx_bytes"

transmit_old=$(<$tx_path)

while true; do
	sleep 1
	transmit_new=$(<$tx_path)
	speed=$((transmit_new - transmit_old))
	transmit_old=$transmit_new
	if [[ $speed -lt 1024 ]];then
		str="$speed B/s"
	elif [[ $speed -lt 1048576 ]];then
		str="$((speed >> 10)) KB/s"
	else
		speed=$(((speed * 10) >> 20))
		str="$((speed / 10)).$((speed % 10)) MB/s"
	fi
	printf '   上传 %9s   \n' "$str"
done
