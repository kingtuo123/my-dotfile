PN := uxplay
PV := latest


USE := default audio dbus
OPT := --network host


run: $(USE)
	docker run --rm -d  --name $(PN) $(OPT) $(PN):$(PV)


bash: $(USE)
	docker run --rm -it --name $(PN) $(OPT) $(PN):$(PV) bash


build:
	docker build -t $(PN):$(PV) --build-arg "USER=$(USER)" --network host .


include ../makefile
