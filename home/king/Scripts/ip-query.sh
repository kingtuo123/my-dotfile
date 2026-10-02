#!/bin/bash

server="cip.cc"  # "ipinfo.io"

if [[ -z "$1" ]];then
	curl $server
	exit 0
elif [[ "$1" == "$( grep -oE '([0-9]{1,3}\.){1,3}[0-9]{1,3}' <<< "$1")" ]];then
	curl $server/$1
else
	ip="$(ping -c1 -W 0.5 $1 | grep '^PING' | grep -Eo '([0-9]{1,3}\.){1,3}[0-9]{1,3}')"
	if [[ -n $ip ]];then
		curl $server/$ip
	fi
fi
