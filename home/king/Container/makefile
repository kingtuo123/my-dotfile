USER := king
UID  := 1000

.SILENT:
all:
	echo "Available use:  default  home  wayland  dbus  audio  gpu  fonts  music"


################################################## - ##################################################
-%:
	:


################################################## default ##################################################
define use_default
OPT += -e XDG_RUNTIME_DIR=/run/user/$(UID)
OPT += -v /tmp/$(UID):/run/user/$(UID)
endef


default: /tmp/$(UID)
	$(eval $(use_default))


/tmp/$(UID):
	mkdir -p $@


################################################## home ##################################################
define use_home
OPT += -v ./homedir:/home/$(USER)
OPT += -e XDG_CONFIG_HOME=/home/$(USER)/.config
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
OPT += -v /run/user/$(UID)/wayland-1:/run/user/$(UID)/wayland-1
endef


wayland: /run/user/$(UID)/wayland-1
	$(eval $(use_wayland))


################################################## dbus ##################################################
define use_dbus
OPT += -e DBUS_SESSION_BUS_ADDRESS=$$$$DBUS_SESSION_BUS_ADDRESS
OPT += -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket
OPT += -v /run/user/$(UID)/bus:/run/user/$(UID)/bus
OPT += -v /run/user/$(UID)/at-spi/bus:/run/user/$(UID)/at-spi/bus
OPT += -v /etc/machine-id:/etc/machine-id
OPT += -v /tmp/dconf:/run/user/$(UID)/dconf
endef


dbus: /run/dbus/system_bus_socket /run/user/$(UID)/bus /run/user/$(UID)/at-spi/bus /etc/machine-id /tmp/dconf
	$(eval $(use_dbus))


/tmp/dconf:
	echo "creating: $@"
	mkdir -p $@


################################################## audio ##################################################
define use_audio
OPT += -v /run/user/$(UID)/pipewire-0:/run/user/$(UID)/pipewire-0
OPT += -v /run/user/$(UID)/pulse/native:/run/user/$(UID)/pulse/native
endef


audio: /run/user/$(UID)/pipewire-0 /run/user/$(UID)/pulse/native
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
OPT += -v ~/.fonts:/home/$(USER)/.fonts
endef


fonts: ~/.fonts
	$(eval $(use_fonts))


################################################## music ##################################################
define use_music
OPT += -v ~/Music:/home/$(USER)/Music
endef


music: ~/Music
	$(eval $(use_music))


