image_name         := wine-base

version            := 10.14

deb_src            :=

deb_path           := ./distdir/deepin-app-store-runtime_1.0.1.1~spark4_all.deb  ./distdir/deepin-wine10-stable_10.14deepin5-spark1_amd64.deb

run_cmd            := /usr/bin/bash

run_script         :=

required_packages  :=

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
