#!/bin/bash

shopt -s nullglob


names=(/sys/class/hwmon/hwmon*/name)


if [[ ${#names[@]} -eq 0 ]]; then
    echo "  未找到文件1  "
    exit 1;
fi


for i in "${names[@]}"; do
    if [[ $(<"$i") == "k10temp" ]]; then
        file_temp="${i%/*}/temp1_input"
    fi
done


if [[ -z "$file_temp" ]]; then
    echo "  未找到文件2  "
    exit 2;
fi



while true; do
    temp=$(<$file_temp)
    temp=$((temp/1000))
    [[ $temp -ge 70 ]] && color="#e67e80" || color="#d3c6aa"
    printf '{"full_text":"   温度  %s℃    ", "color":"%s"}\n' $temp  $color
    sleep 2
done
