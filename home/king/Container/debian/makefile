# 构建的镜像名称
image_name         := debian-base
# 构建的镜像版本
version            := trixie


# 运行时的容器名称
container_name     := $(image_name)
# 容器内的用户名称
container_username := debian
# 容器内的用户UID
container_userid   := $$UID
# 容器内的家目录
container_home     := /home/$(container_username)


# 家目录
host_homedir       := $$PWD/homedir
# 文件目录
host_files         := $$PWD/files


# 容器内需要安装的软件包
required_packages := xwayland dbus pulseaudio bash-completion fonts-wqy-microhei 
required_packages += fcitx5 fcitx5-config-qt fcitx5-frontend-gtk3 fcitx5-frontend-gtk2 fcitx5-frontend-qt5


# 容器运行参数
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


# 镜像构建参数
build_args := --network host 
build_args += -t $(image_name):$(version)
build_args += --build-arg "NAME=$(container_username)"
build_args += --build-arg "UID=$(container_userid)"
build_args += --build-arg "PACKAGES=$(required_packages)"


####################################################################################################################
is_container_running := $(strip $(shell docker container ls --filter name=$(container_name) --quiet))
is_image_exist       := $(strip $(shell docker images | grep $(image_name) | grep $(version)))


bash: image
ifdef is_container_running
	@docker exec -it  $(container_name) bash
else
	@docker run -it $(run_args) $(image_name):$(version) bash
endif


image:
ifndef is_image_exist
	@docker build . $(build_args)
endif
