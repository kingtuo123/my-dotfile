#!/bin/bash
export $(</tmp/my-dbus)
notify-send -t 10000 "蓝牙" "设备已连接"
sleep 1
pkill -SIGRTMIN+2 i3blocks
