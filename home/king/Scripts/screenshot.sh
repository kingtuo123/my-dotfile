#!/bin/bash


area=$(slurp 2>/dev/null)

[[ -z $area ]] && exit 0

tmpimg="/tmp/.screenshot.png"

grim -g "$area" $tmpimg

w=$(file /tmp/.screenshot.png | grep -Po '[0-9]+(?= x)')
h=$(file /tmp/.screenshot.png | grep -Po '(?<=x )[0-9]+')

swayimg -a "screenshot"  -w $((w/2)),$((h/2)) $tmpimg

result=$( echo -e "是\n否 " | wmenu -p '          是否保存图片          ' -l 5 -f ' Microsoft YaHei UI 9.5' -N '#232a2e' -n '#d3c6aa' -M '#A7C080' -m '#232a2e' -S '#A7C080' -s '#232a2e' )

[[ $result =~ 是 ]] && cp $tmpimg ~/Pictures/Screenshots/$(date '+%Y-%m-%d-%H%M%S').png
