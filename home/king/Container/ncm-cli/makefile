PN  := ncm-cli
PV  := latest


USE := default  home  dbus  audio
OPT := --network bridge


run: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --network host .


include ../makefile
