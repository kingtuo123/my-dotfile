#!/bin/bash

#/usr/bin/google-chrome --enable-features=UseOzonePlatform --ozone-platform=wayland --use-gl=angle --disable-gpu --disable-hardware-acceleration
#/usr/bin/google-chrome --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-hardware-acceleration
exec /usr/bin/google-chrome --disable-features=WaylandWpColorManagerV1 --force-color-profile=srgb --enable-features=UseOzonePlatform --ozone-platform=wayland
