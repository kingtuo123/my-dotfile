if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi


echo -e "\nHello ${USER} !\n"


#export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export NO_AT_BRIDGE=1
export WLR_RENDERER=vulkan
export XDG_CONFIG_HOME=${HOME}/.config
export PATH+=:${HOME}/Scripts:/opt/arm-gnu-toolchain/bin



export WIN10_DESKTOP="my-win10/Users/Administrator/Desktop"



if [[ -z "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
    log="/tmp/dbus.log"
    if [[ -e ${log} ]]; then
        export DBUS_SESSION_BUS_ADDRESS=$(<${log})
    else
        dbus-daemon --session --address=unix:path=/run/user/$(id -u)/bus --fork --print-address > ${log}
        export DBUS_SESSION_BUS_ADDRESS=$(<${log})
        /usr/libexec/at-spi-bus-launcher --launch-immediately &
    fi
    unset log
fi




if [[ -z "$(pgrep sway)" ]]; then
    exec sway &>/tmp/sway.log
fi
