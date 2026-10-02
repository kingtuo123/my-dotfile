#!/bin/bash

#  ddcutil probe 查询显示器可用代码，输出如下：
#  Feature x0b - Color temperature increment
#  Feature x0c - Color temperature request
#  Feature x10 - Brightness
#  Feature x12 - Contrast
#  Feature x14 - Select color preset
#  Feature x16 - Video gain: Red
#  Feature x18 - Video gain: Green
#  Feature x1a - Video gain: Blue
#  Feature x1e - Auto setup
#  Feature x20 - Horizontal Position (Phase)
#  Feature x30 - Vertical Position (Phase)
#  Feature x52 - Active control
#  Feature x60 - Input Source
#  Feature x62 - Audio speaker volume
#  Feature x6c - Video black level: Red
#  Feature x6e - Video black level: Green
#  Feature x70 - Video black level: Blue
#  Feature x87 - Sharpness
#  Feature xac - Horizontal frequency
#  Feature xae - Vertical frequency
#  Feature xb2 - Flat panel sub-pixel layout
#  Feature xb6 - Display technology type
#  Feature xc6 - Application enable key
#  Feature xc8 - Display controller type
#  Feature xc9 - Display firmware level
#  Feature xca - OSD/Button Control
#  Feature xcc - OSD Language
#  Feature xd6 - Power mode
#  Feature xdf - VCP Version
#  Feature xe6 - Manufacturer Specific


case $button in
    3)
        rofiTheme="window { border-radius:0px; location: northeast; x-offset: -320px; y-offset: 0px; width: 50px; } inputbar { enabled: false; } element-text { padding:5px; }"
        selectedBrightness=$(printf '%d\n' {10..100..10} | rofi -dmenu -theme-str "$rofiTheme" -l 10)
        if [[ -n $selectedBrightness ]]; then
            ddcutil setvcp 10 $selectedBrightness
        fi
        ;;
    # 4) ddcutil setvcp 10 + 5 ;;
    # 5) ddcutil setvcp 10 - 5 ;;
    *) ;;
esac



brightness=$(ddcutil getvcp 10 | grep -Po '[0-9]*(?=,)')


printf '   亮度  %s%%   \n' $brightness
