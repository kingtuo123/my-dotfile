PN  := swayimg
PV  := latest


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network none


dir ?= $(PWD)
OPT += -v $(dir):/mnt:ro


run: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --network host .


include ../makefile
