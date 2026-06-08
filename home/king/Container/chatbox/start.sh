#!/bin/bash

exec /opt/Chatbox/xyz.chatboxapp.app --disable-features=WaylandWpColorManagerV1 --force-color-profile=srgb --enable-features=UseOzonePlatform --ozone-platform=wayland
