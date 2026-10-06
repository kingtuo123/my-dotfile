#!/bin/sh

city=330324

keyfile="${HOME}/.config/amap/key"

if [ ! -e "${keyfile}" ]; then
    printf '{"full_text":"   天气  keyfile 不存在   ", "color":"#e67e80"}\n'
    exit 0
fi

key=$(cat "${keyfile}")

until data=$(curl -sS --connect-timeout 5 "https://restapi.amap.com/v3/weather/weatherInfo?key=${key}&city=${city}"); do
    sleep 5
done

city=$(echo ${data} | jq -r .lives[0].city)
weather=$(echo ${data} | jq -r .lives[0].weather)
temperature=$(echo ${data} | jq -r .lives[0].temperature)
humidity=$(echo ${data} | jq -r .lives[0].humidity)

printf '{"full_text":"   %s  %s  %s℃  %s%%   ", "color":"#d3c6aa"}\n' "${city}" "${weather}" "${temperature}" "${humidity}"
