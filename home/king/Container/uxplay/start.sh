#!/bin/bash

sudo avahi-daemon --no-chroot --no-drop-root &

sleep 1s

uxplay
