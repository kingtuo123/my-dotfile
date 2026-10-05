#!/bin/bash

if [[ ! $UID -eq 0 ]];then
	echo "plz run as root"
	exit 1
fi

chrome="/opt/google/chrome/google-chrome"
edge="/opt/microsoft/msedge/microsoft-edge"

if [[ -f "$chrome" && -z "$(grep force-device-scale-factor $chrome)" ]];then
	sed -i '$s/$/ --force-device-scale-factor=2/' $chrome
	sed -i '$s/$/ --password-store=basic/' $chrome
	echo "fix chrome"
else
	echo "skip chrome"
fi

if [[ -f "$edge" && -z "$(grep force-device-scale-factor $edge)" ]];then
	sed -i '$s/$/ --force-device-scale-factor=2/' $edge
	echo "fix edge"
else
	echo "skip edge"
fi
