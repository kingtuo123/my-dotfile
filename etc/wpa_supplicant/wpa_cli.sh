#!/bin/bash

if [ -z "$1" -o -z "$2" ]; then
	logger -t wpa_cli "Insufficient parameters"
	exit 1
fi

INTERFACE="$1"
ACTION="$2"

# 请注意，以下操作不得通过 ifconfig、ip 命令或类似方式关闭网络接口。
# IP 地址可以被删除、修改，net.${INTERFACE} 守护进程也可以被停止，但网络接口必须保持开启 UP 状态，以便 wpa_supplicant 正常工作。

if [ -f /etc/gentoo-release ]; then
	EXEC="/etc/init.d/net.${INTERFACE} --quiet"
else
	logger -t wpa_cli "I don't know what to do with this distro!"
	exit 1
fi

case ${ACTION} in
	CONNECTED)
		/usr/bin/pkill -SIGRTMIN+5 i3blocks
		logger -t wpa_cli "CONNECTED: pkill -SIGRTMIN+5 i3blocks"
		exit 0
		#EXEC="${EXEC} start"
		;;
	DISCONNECTED)
		/usr/bin/pkill -SIGRTMIN+5 i3blocks
		logger -t wpa_cli "DISCONNECTED: pkill -SIGRTMIN+5 i3blocks"
		exit 0
		#EXEC="${EXEC} --nodeps stop"
		;;
	*)
		logger -t wpa_cli "Unknown action ${ACTION}"
		exit 1
		;;
esac

# IN_BACKGROUND 变量告知 net.${INTERFACE} 脚本：该操作是后台进程 wpa_cli 触发的
export IN_BACKGROUND=true

logger -t wpa_cli "interface ${INTERFACE} ${ACTION}"
${EXEC} || logger -t wpa_cli "executing '${EXEC}' failed"
