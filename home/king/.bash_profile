#if [[ -f ~/.bashrc ]] ; then
#	. ~/.bashrc
#fi



echo ""
echo "Hello $USER !"
echo ""



#export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export NO_AT_BRIDGE=1
export WLR_RENDERER=vulkan
export XDG_CONFIG_HOME=$HOME/.config
export PATH+=:/home/king/Scripts



if [[ -z "$DBUS_SESSION_BUS_ADDRESS" ]]; then
	dbus="/tmp/my-dbus"
	if [[ -f $dbus ]]; then
		export $(<$dbus)
	else
		dbus-launch > $dbus
		export $(<$dbus)
	fi
	unset dbus
fi



if [[ -z $WAYLAND_DISPLAY ]]; then
	exec sway &>/tmp/sway.log
fi
