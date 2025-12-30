#!/bin/bash

file_temp="/sys/class/hwmon/hwmon5/temp1_input"

while true; do
	temp=$(<$file_temp)
	temp=$((temp/1000))
	[[ $temp -ge 70 ]] && color="#e67e80" || color="#d3c6aa"
	printf '{"full_text":"   温度  %s℃    ", "color":"%s"}\n' $temp  $color
	sleep 2
done
