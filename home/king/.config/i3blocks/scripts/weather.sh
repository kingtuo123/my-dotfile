#!/bin/bash

key=$(cat ~/.config/amap/key)
city=330382

until data=$(curl -sS --connect-timeout 5 "https://restapi.amap.com/v3/weather/weatherInfo?key=$key&city=$city"); do
	sleep 5
done

city=$(echo $data | jq -r .lives[0].city)
weather=$(echo $data | jq -r .lives[0].weather)
temperature=$(echo $data | jq -r .lives[0].temperature)
humidity=$(echo $data | jq -r .lives[0].humidity)

printf '{"full_text":"   %s  %s  %s℃  %s%%   "}\n' $city $weather $temperature $humidity
