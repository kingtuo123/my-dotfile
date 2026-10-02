#!/bin/bash

function github_release_check() {
	current=$(equery l $1 -o | tail -n 1 | grep $1 | sed "s#$1##g" | sed 's/-//' | sed 's/-.*$//')
	latest=$(curl -sL https://api.github.com/repos/$2/releases/latest | jq -r ".tag_name" | sed 's/v//')
	echo -e "\e[1;32m*\e[0m\e[1;38m $1 \e[0m"
	if [[ $current == $latest ]];then
		echo -e "current: \e[1;32m$current\e[0m"
	else
		echo -e "current: \e[1;31m$current\e[0m"
	fi
	echo -e "latest: \e[1;32m$latest\e[0m\n"
}

github_release_check "media-video/uxplay" "FDH2/uxplay"

github_release_check "dev-embedded/stlink" "stlink-org/stlink"
github_release_check "dev-embedded/tinyserial" "carloscn/tinyserial"

github_release_check "net-misc/v2raya" "v2rayA/v2rayA"
github_release_check "net-misc/xray-core" "XTLS/Xray-core"
#github_release_check "net-misc/clash-verge" "clash-verge-rev/clash-verge-rev"
