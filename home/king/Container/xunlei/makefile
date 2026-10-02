image_name         := xunlei

version            := 1.0.0.1

deb_src            :=

deb_path           := ./distdir/com.xunlei.download_$(version)_amd64.deb

run_cmd            :=

run_script         := ./start.sh

required_packages  := libxss1 libnss3 libdbus-glib-1-2 libgtk2.0-0

shm_size           := 1g

cap_add            := SYS_ADMIN

is_privileged      :=

is_x11             := true

is_map_fontsdir    := true

include ../common/common.mk




# shm_size 共享内存，单位 m、g。

# cap_add 容器内权限
#         SYS_ADMIN  ：极高，系统管理、命名空间、挂载等（避免授予）
#         SYS_PTRACE ：中等，调试进程、strace
#         NET_ADMIN  ：中等，修改网络配置
#         IPC_OWNER  ：较低，绕过共享内存权限检查
