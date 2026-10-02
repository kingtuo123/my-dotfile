#!/bin/bash

rx_path="/sys/class/net/wlp4s0/statistics/rx_bytes"

recive_old=$(<$rx_path)

while true; do
	sleep 1
	recive_new=$(<$rx_path)
	speed=$((recive_new - recive_old))
	recive_old=$recive_new
	if [[ $speed -lt 1024 ]];then
		str="$speed B/s"
	elif [[ $speed -lt 1048576 ]];then
		str="$((speed >> 10)) KB/s"
	else
		speed=$(((speed * 10) >> 20))
		str="$((speed / 10)).$((speed % 10)) MB/s"
	fi
	printf '   下载 %9s   \n' "$str"
done
