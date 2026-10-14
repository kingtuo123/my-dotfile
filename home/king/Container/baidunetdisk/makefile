PN  := baidunetdisk
PV  := 8.7.0


USE := default  home  wayland  dbus  audio  gpu  fonts
OPT := --network bridge


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build: ./distdir/$(PN)-$(PV).deb
	docker build -t $(PN):$(PV) --build-arg "DEB=$(PN)-$(PV).deb" --network host .


%.deb:
	mkdir -p distdir
	echo "缺少：$@"
	exit 1


include ../makefile
