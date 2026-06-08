#!/bin/bash

if [[ -e "/tmp/.X0-lock" ]]; then
    rm -f /tmp/.X0-lock
fi

Xwayland :0 &

sleep 0.5

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=2
export QT_AUTO_SCALE_FACTOR=0
export _JAVA_OPTIONS='-Dsun.java2d.uiScale=2'
echo "Xft.dpi: 192" | xrdb -merge

exec jwm
