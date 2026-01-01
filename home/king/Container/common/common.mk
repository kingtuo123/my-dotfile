container_name       := $(image_name)
container_home       := /home/debian
host_homedir         := ./homedir
host_files           := ./files
host_distdir         := ./distdir
is_container_running := $(strip $(shell docker container ls --filter name=$(container_name) --quiet))
is_image_exist       := $(strip $(shell docker images | grep $(image_name) | grep $(version)))
is_custom_start      := $(strip $(findstring start.sh,$(target_bin)))
is_deb_target        := $(strip $(findstring .deb,$(target_name)))





########################################################################################################
run_args += --rm
run_args += --name $(container_name)
run_args += --privileged
run_args += --network host
run_args += -e IMAGE_NAME=$(image_name):$(version)
run_args += -e WAYLAND_DISPLAY=$$WAYLAND_DISPLAY
run_args += -e DBUS_SESSION_BUS_ADDRESS=$$DBUS_SESSION_BUS_ADDRESS
run_args += -e XMODIFIERS=@im=fcitx
run_args += -e QT_IM_MODULE=fcitx
run_args += -e GTK_IM_MODULE=fcitx
run_args += -e XDG_RUNTIME_DIR=$$XDG_RUNTIME_DIR
run_args += -e DISPLAY=:0
run_args += -v $$XDG_RUNTIME_DIR:$$XDG_RUNTIME_DIR
run_args += -v /etc/machine-id:/etc/machine-id:ro
run_args += -v /dev:/dev
run_args += -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket
run_args += -v /tmp:/tmp
run_args += -v $(host_homedir):$(container_home)
run_args += -v $$HOME/.fonts:$(container_home)/.fonts:ro

ifdef is_custom_start
run_args += -v $(host_files)/start.sh:$(target_bin)
endif





#######################################################################################################
ifdef is_deb_target
build_args += -f ../common/dockerfile.target
else ifdef required_packages
build_args += -f ../common/dockerfile.no-target
endif

build_args += --network host 
build_args += -t $(image_name):$(version)
build_args += --build-arg "TARGEET=$(target_name)"
build_args += --build-arg "PACKAGES=$(required_packages)"





#######################################################################################################
run: image
ifdef is_container_running
	@docker kill $(container_name)
	@sleep 0.5s
endif
	@docker run -d $(run_args) $(image_name):$(version) $(target_bin)


bash: image
ifdef is_container_running
	@docker exec -it $(container_name) bash
else
	@docker run -it $(run_args) $(image_name):$(version) bash
endif


image: $(host_homedir) $(host_files) $(host_distdir) $(target_name)
ifndef is_image_exist
	@docker build . $(build_args)
endif


$(target_name):
	@curl -L $(target_src) -o $(target_name)


$(host_homedir):
	@mkdir -p $@


$(host_files):
ifdef is_custom_start
	@mkdir -p $@
	@cp -in ../common/start.sh $@
endif


$(host_distdir):
ifdef target_name
	@mkdir -p $@
endif
