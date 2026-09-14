#!/bin/bash

case $button in
    3)
        networks=$(wpa_cli list_networks | cut -f 1-2 |tail -n +3)
        lines=$(wpa_cli list_networks | tail -n +3 | wc -l)
        if [[ -n "$networks" ]]; then
            rofiTheme="window { border-radius:0px; location: northwest; x-offset: $(($BLOCK_X - 100))px; y-offset: 0px; width: 10%; } inputbar { enabled: false; } element-text { padding:5px; }"
            selectedNetwork=$(printf "%s\n" "${networks}" | rofi -dmenu -theme-str "$rofiTheme" -l $lines)
            if [[ -n "$selectedNetwork" ]]; then
                num=$(echo $selectedNetwork | cut -d ' ' -f1)
                wpa_cli select_network $num &> /dev/null
            fi
        fi
        ;;
    *) ;;
esac

ssid=$(wpa_cli status | grep -Po '(?<=^ssid=).*')

if [[ -z $ssid ]]; then
    ssid="--"
    color="#e67e80"
else
    color="#d3c6aa"
fi

#ip_address=$(wpa_cli status | grep -Po '(?<=^ip_address=).*')
#
#if [[ -z $ip_address ]]; then
#    ip_address="--"
#    color="#e67e80"
#else
#    color="#d3c6aa"
#fi
#
#printf '{"full_text":"   无线  %s  %s   ", "color":"%s"}\n' "$ssid" "$ip_address" $color

printf '{"full_text":"   无线网  %s   ", "color":"%s"}\n' "$ssid" $color
