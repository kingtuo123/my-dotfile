.SILENT:
all:
	echo "Available use:  home  wayland  dbus  audio  gpu  fonts  music"


################################################## default ##################################################
define use_default
OPT += -e XDG_RUNTIME_DIR=/run/user/1000
OPT += -v /tmp/1000:/run/user/1000
endef


default: /tmp/1000
	$(eval $(use_default))


/tmp/1000:
	mkdir -p $@


################################################## home ##################################################
define use_home
OPT += -v ./homedir:/home/debian
OPT += -e XDG_CONFIG_HOME=/home/debian/.config
endef


home: homedir
	$(eval $(use_home))


homedir:
	echo "creating: $@"
	mkdir -p $@


################################################## wayland ##################################################
define use_wayland
OPT += -e WAYLAND_DISPLAY=wayland-1
OPT += -e XDG_SESSION_TYPE=wayland
OPT += -v /run/user/1000/wayland-1:/run/user/1000/wayland-1
endef


wayland: /run/user/1000/wayland-1
	$(eval $(use_wayland))


################################################## dbus ##################################################
define use_dbus
OPT += -e DBUS_SESSION_BUS_ADDRESS=$$DBUS_SESSION_BUS_ADDRESS
OPT += -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket
OPT += -v /run/user/1000/bus:/run/user/1000/bus
OPT += -v /run/user/1000/at-spi/bus:/run/user/1000/at-spi/bus
OPT += -v /etc/machine-id:/etc/machine-id
OPT += -v /tmp/dconf:/run/user/1000/dconf
endef


dbus: /run/dbus/system_bus_socket /run/user/1000/bus /run/user/1000/at-spi/bus /etc/machine-id /tmp/dconf
	$(eval $(use_dbus))


/tmp/dconf:
	echo "creating: $@"
	mkdir -p $@


################################################## audio ##################################################
define use_audio
OPT += -v /run/user/1000/pipewire-0:/run/user/1000/pipewire-0
OPT += -v /run/user/1000/pulse/native:/run/user/1000/pulse/native
endef


audio: /run/user/1000/pipewire-0 /run/user/1000/pulse/native
	$(eval $(use_audio))


################################################## gpu ##################################################
define use_gpu
OPT += --device /dev/dri
OPT += --shm-size=1g
OPT += --cap-add=SYS_ADMIN
endef


gpu: /dev/dri
	$(eval $(use_gpu))


################################################## fonts ##################################################
define use_fonts
OPT += -v ~/.fonts:/home/debian/.fonts
endef


fonts: ~/.fonts
	$(eval $(use_fonts))


################################################## music ##################################################
define use_music
OPT += -v ~/Music:/home/debian/Music
endef


music: ~/Music
	$(eval $(use_music))


