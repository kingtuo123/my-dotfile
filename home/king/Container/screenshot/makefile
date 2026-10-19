PN  := screenshot
PV  := latest


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network none


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --network host .


include ../makefile
