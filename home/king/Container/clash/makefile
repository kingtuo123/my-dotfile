PN  := clash
PV  := 2.5.8
URI := https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v$(PV)/Clash.Verge_$(PV)_amd64.deb


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network host


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch:
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


include ../makefile
