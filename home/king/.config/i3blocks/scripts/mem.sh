#!/bin/bash

file_meminfo="/proc/meminfo"

declare -a data

while true; do
	n=0
	while read f1 f2 f3; do
		data[$((n++))]=$f2
		if [[ $n -gt 2 ]]; then
			break
		fi
	done < $file_meminfo

	used=$(((data[0] - data[2]) >> 10))
	if [[ $used -lt 1024 ]]; then
		used=${used}M
	else
		used=$((((used + 50) * 10) >> 10))
		used=$((used / 10)).$((used % 10))G
	fi

	avail=$((data[2] >> 10))
	[[ $avail -lt 4096 ]] && color="#e67e80" || color="#d3c6aa"
	if [[ $avail -lt 1024 ]]; then
		avail=${avail}M
	else
		avail=$((avail >> 10))G
	fi

	printf '{"full_text":"   内存已用  %s  剩余  %s   ", "color":"%s"}\n' $used $avail $color

	sleep 2
done
