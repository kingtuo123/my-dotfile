PN  := drawio
PV  := 32.4.1
URI := https://github.com/jgraph/drawio-desktop/releases/download/v$(PV)/drawio-amd64-$(PV).deb


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network none


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch:
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


include ../makefile
