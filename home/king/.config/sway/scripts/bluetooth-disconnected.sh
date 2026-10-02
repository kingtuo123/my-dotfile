#!/bin/bash
export $(</tmp/my-dbus)
notify-send -t 10000 "蓝牙" "设备已断开"
pkill -SIGRTMIN+2 i3blocks
