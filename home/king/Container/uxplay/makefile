image_name         := uxplay

version            := 1.71.1-1

deb_src            :=

deb_path           :=

run_cmd            :=

run_script         := ./start.sh

required_packages  := uxplay gstreamer1.0-plugins-good gstreamer1.0-plugins-bad

shm_size           :=

cap_add            :=

is_privileged      :=

is_x11             :=

is_map_fontsdir    :=

run_args           := -v ./avahi-dbus.conf:/etc/dbus-1/system.d/avahi-dbus.conf

include ../common/common.mk




# shm_size 共享内存，单位 m、g。

# cap_add 容器内权限
#         SYS_ADMIN  ：极高，系统管理、命名空间、挂载等（避免授予）
#         SYS_PTRACE ：中等，调试进程、strace
#         NET_ADMIN  ：中等，修改网络配置
#         IPC_OWNER  ：较低，绕过共享内存权限检查
