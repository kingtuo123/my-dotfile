#!/bin/bash

key=$(cat ~/.config/amap/key)
city=330382

until data=$(curl -sS --connect-timeout 5 "https://restapi.amap.com/v3/weather/weatherInfo?key=$key&city=$city"); do
	sleep 5
done

weather=$(echo $data | jq -r .lives[0].weather)
temperature=$(echo $data | jq -r .lives[0].temperature)
humidity=$(echo $data | jq -r .lives[0].humidity)

printf '{"full_text":"   %s  %s℃  %s%%   "}\n' $weather $temperature $humidity
