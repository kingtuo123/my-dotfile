#!/bin/bash

NtpServer=(
	"上海交大 NTP 服务器:		ntp.sjtu.edu.cn"
	"国家授时中心 NTP 服务器:	ntp.ntsc.ac.cn"
	"中国 NTP 快速授时服务:		cn.ntp.org.cn"
	"阿里云公共 NTP 服务器:		ntp1.aliyun.com"
	"腾讯公共 NTP 服务器:		ntp.tencent.com"
	"清华大学 NTP 服务器:		ntp.tuna.tsinghua.edu.cn"
)


for (( i=0; i < ${#NtpServer[@]}; i++)); do
	echo "[$((i+1))] ${NtpServer[i]%%:*}"
done


read -p "Select Server (Default 1): " num
if [[ -z "$num" || "$num" =~ [^0-9] || "$num" -gt ${#NtpServer[@]} || "$num" -le 0 ]]; then
	num=1
fi


echo -e "\n\e[1;34m[$num] ${NtpServer[$(( num-1 ))]%%:*}\e[0m\n"


if [[ $UID -ne 0 ]]; then
	echo "Need root privilege"
	sudo bash -c "ntpdate ${NtpServer[$((num-1))]##*:} && hwclock -w"
else
	ntpdate ${NtpServer[$((num-1))]##*:} && hwclock -w
fi
