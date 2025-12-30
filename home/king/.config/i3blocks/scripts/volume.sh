#!/bin/bash

case $button in
	3) 
		rofiTheme="window { border-radius:0px; location: northeast; x-offset: 0px; y-offset: 0px; width: 30%; } inputbar { enabled: false; } element-text { padding:5px; }"
		defaultSink=$(pactl get-default-sink)
		sinks=($(pactl list sinks short | cut -f2))
		for i in "${!sinks[@]}";do
			if [[ "${sinks[$i]}" == "$defaultSink" ]];then
				sinks[$i]="[■] ${sinks[$i]}"
				currentSink=$i
			else
				sinks[$i]="[ ] ${sinks[$i]}"
			fi
		done
		selectedSink=$(printf "%s\n" "${sinks[@]}" | rofi -dmenu -theme-str "$rofiTheme" -l ${#sinks[@]} -selected-row $currentSink)
		if [[ -n $selectedSink ]]; then
			pactl set-default-sink "${selectedSink##\[*\] }" &>/dev/null
		fi
		;;
    2) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
    4) pactl set-sink-volume @DEFAULT_SINK@ +2% ;;
    5) pactl set-sink-volume @DEFAULT_SINK@ -2% ;;
    *) ;;
esac

until mute=$(pactl get-sink-mute @DEFAULT_SINK@); do
	sleep 2
done

vol=$(pactl get-sink-volume @DEFAULT_SINK@)
vol=${vol#*/}
vol=${vol%%/*}

[[ $mute =~ yes ]] && { title="静音";color="#e67e80"; } || { title="音量";color="#d3c6aa"; }

printf '{"full_text":"   %s  %3s   ", "color":"%s"}\n' $title $vol $color
