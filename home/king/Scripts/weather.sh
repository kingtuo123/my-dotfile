#!/bin/bash

location="Yueqing"

if [[ $1 == 'h' ]];then
	curl "wttr.in/:help" 
elif [[ -z $1 ]];then
	curl "wttr.in/$location?lang=zh&1"
else
	curl "wttr.in/$location?lang=zh&$1"
fi
