PN := debian-base
PV := latest


USE := default home  wayland  audio  dbus  gpu  fonts
OPT := --network host


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV)


build:
	docker build -t $(PN):$(PV) --network host .


include ../makefile
