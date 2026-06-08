#!/bin/bash

exec /usr/bin/CherryStudio --disable-features=WaylandWpColorManagerV1 --force-color-profile=srgb --enable-features=UseOzonePlatform --ozone-platform=wayland
