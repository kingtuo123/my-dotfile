#!/bin/bash

if [[ -e "/tmp/.X0-lock" ]]; then 
	rm -f /tmp/.X0-lock
fi

Xwayland :0 &

sleep 0.5 

jwm
