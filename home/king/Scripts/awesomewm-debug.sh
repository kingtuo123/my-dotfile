#!/bin/bash

sleep 0.5 && DISPLAY=:1.0 awesome &

Xephyr :1 -ac -host-cursor -nolisten tcp -br -noreset -screen 3840x2332
