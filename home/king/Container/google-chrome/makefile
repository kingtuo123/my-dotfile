PN  := googlel-chrome
PV  := 155.0.8059.39
URI := https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_$(PV)-1_amd64.deb


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network host


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch:
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


include ../makefile
