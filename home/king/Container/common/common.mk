container_name       := $(image_name)
container_home       := /home/debian
host_homedir         := ./homedir
host_distdir         := ./distdir





################################################### 运行参数 ##############################################################
run_args += --rm
run_args += --network host
run_args += --name $(container_name)
run_args += --device /dev/dri



run_args += -v $(host_homedir):$(container_home)
run_args += -v /tmp:/tmp
run_args += -v /etc/machine-id:/etc/machine-id:ro
run_args += -v /run/user/1000:/run/user/1000
run_args += -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket



run_args += -e IMAGE_NAME=$(image_name):$(version)
run_args += -e WAYLAND_DISPLAY=$$WAYLAND_DISPLAY
run_args += -e DBUS_SESSION_BUS_ADDRESS=$$DBUS_SESSION_BUS_ADDRESS
run_args += -e XDG_RUNTIME_DIR=/run/user/1000



ifdef shm_size
run_args += --shm-size=$(shm_size)
endif

ifdef cap_add
run_args += --cap-add=$(cap_add)
endif

ifdef is_privileged
run_args += --privileged
endif

ifdef is_x11
run_args += -e DISPLAY=:0
run_args += -e GTK_IM_MODULE=fcitx
run_args += -e QT_IM_MODULE=fcitx
run_args += -e XMODIFIERS=@im=fcitx
run_args += -e GLFW_IM_MODULE=ibus
required_packages += fcitx5-frontend-gtk2 fcitx5-frontend-gtk3 fcitx5-frontend-gtk4 fcitx5-frontend-qt5 fcitx5-frontend-qt6
endif

ifdef is_map_fontsdir
run_args += -v $$HOME/.fonts:$(container_home)/.fonts:ro
endif





################################################## 构建参数 ################################################################
build_args += --network host
build_args += -f ../common/dockerfile
build_args += -t $(image_name):$(version)
build_args += --build-arg DEB_PATH="$(deb_path)"
build_args += --build-arg REQUIRED_PACKAGES="$(required_packages)"





################################################# 目标 #####################################################################
is_container_running := $(strip $(shell docker container ls --filter name=$(container_name) --quiet))
is_image_exist       := $(strip $(shell docker images --format "{{.Repository}}:{{.Tag}}" | grep $(image_name):$(version)))



# 后台运行容器内应用
run: image
ifdef is_container_running
	@docker kill $(container_name)
	@sleep 0.5s
endif
ifdef run_cmd
	@docker run -d $(run_args) $(image_name):$(version) $(run_cmd)
endif
ifdef run_script
	@docker run -d $(run_args) -v $(run_script):/usr/local/bin/start.sh $(image_name):$(version) start.sh
endif



# 进入容器 bash，用于调试
bash: image
ifdef is_container_running
	@docker exec -it $(container_name) bash
else
ifdef run_cmd
	@docker run -it $(run_args) $(image_name):$(version) bash
endif
ifdef run_script
	@docker run -it $(run_args) -v $(run_script):/usr/local/bin/start.sh $(image_name):$(version) bash
endif
endif



# 构建镜像
image: $(host_homedir) $(host_distdir) $(deb_path)
ifndef is_image_exist
	@docker build . $(build_args)
endif



# 下载 deb 文件
$(deb_path):
	@curl -L $(deb_src) -o $(deb_path)



# 创建 ./homedir 目录
$(host_homedir):
	@mkdir -p $@



# 创建 ./distdir 目录
$(host_distdir):
	@mkdir -p $@
