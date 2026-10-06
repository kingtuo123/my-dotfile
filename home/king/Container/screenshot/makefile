PN  := screenshot
PV  := latest

# must required
OPT := --network host
OPT += -v ./homedir:/home/debian
# wayland
OPT += -e WAYLAND_DISPLAY=wayland-1
OPT += -v /run/user/1000/wayland-1:/run/user/1000/wayland-1
# pipewire & pulseaudio
OPT += -v /run/user/1000/pipewire-0:/run/user/1000/pipewire-0
OPT += -v /run/user/1000/pulse/native:/run/user/1000/pulse/native
# dbus
OPT += -e DBUS_SESSION_BUS_ADDRESS=$$DBUS_SESSION_BUS_ADDRESS
OPT += -v /run/user/1000/bus:/run/user/1000/bus
OPT += -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket
OPT += -v /run/user/1000/at-spi/bus:/run/user/1000/at-spi/bus
OPT += -v /tmp/dconf:/run/user/1000/dconf
# optional
OPT += -v /etc/machine-id:/etc/machine-id
OPT += --device /dev/dri
OPT += --shm-size=1g
OPT += --cap-add=SYS_ADMIN
#OPT += --privileged
#OPT += -v ~/Music:/home/debian/Music
OPT += -v ~/.fonts:/home/debian/.fonts

OPT += -v ./screenshot:/usr/bin/screenshot
OPT += -v ./config:/home/debian/.config/swayimg/config

.SILENT:
run: homedir /tmp/dconf
	docker run --rm  -d --name $(PN) $(OPT) $(PN):$(PV)


bash: homedir /tmp/dconf
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --network host .


homedir:
	mkdir -p $@

/tmp/dconf:
	mkdir -p $@
