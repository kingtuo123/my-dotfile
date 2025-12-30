#!/bin/bash

read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 </proc/stat
total_old=$((f2+f3+f4+f5+f6+f7+f8+f9))
idle_old=$((f5+f6))

while true; do
	sleep 1
	read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 </proc/stat
	total_now=$((f2+f3+f4+f5+f6+f7+f8+f9))
	idle_now=$((f5+f6))
	total_d=$((total_now - total_old))
	idle_d=$((idle_now - idle_old))
	usage=$((100 - 100*idle_d/total_d))
	idle_old=$idle_now
	total_old=$total_now
	[[ $usage -ge 50 ]] && color="#e67e80" || color="#d3c6aa"
	printf '{"full_text":"   处理器 %3d%%   ", "color":"%s"}\n' $usage $color
done
