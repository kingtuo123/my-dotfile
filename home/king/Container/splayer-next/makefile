PN := splayer-next


SELECT := nightly


define use_nightly
PV  := 1.2.0-nightly.979
URI := https://github.com/SPlayer-Dev/SPlayer-Next/releases/download/nightly/splayer-next-$$(PV)-amd64.deb
endef


define use_stable
PV  := 1.1.0
URI := https://github.com/SPlayer-Dev/SPlayer-Next/releases/download/v$$(PV)/splayer-next-$$(PV)-amd64.deb
endef


USE := default  home  wayland  dbus  audio  gpu  fonts  music
OPT := --network bridge


run: $(SELECT) $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(SELECT) $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build: $(SELECT)
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --build-arg "DEB=$(PN)-$(PV).deb" --network host .


fetch: $(SELECT)
	curl -L $(URI) -C - --create-dirs -o ./distdir/$(PN)-$(PV).deb


nightly:
	$(eval $(use_nightly))


stable:
	$(eval $(use_stable))


include ../makefile
