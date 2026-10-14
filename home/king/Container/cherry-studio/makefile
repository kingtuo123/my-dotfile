PN  := cherry-studio
PV  := 2.1.6
URI := https://github.com/CherryHQ/cherry-studio/releases/download/v$(PV)/Cherry-Studio-$(PV)-linux-x64.deb


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network bridge


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch:
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


include ../makefile
