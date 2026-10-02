image_name         := clash-verge-rev

version            := 2.5.2

deb_src            := https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v$(version)/Clash.Verge_$(version)_amd64.deb

deb_path           := ./distdir/clash-verge_$(version)_amd64.deb

run_cmd            := /usr/bin/clash-verge

run_script         :=

required_packages  := libappindicator3-1

shm_size           := 1g

cap_add            :=

is_privileged      :=

is_x11             :=

is_map_fontsdir    := true

include ../common/common.mk




# shm_size 共享内存，单位 m、g。

# cap_add 容器内权限
#         SYS_ADMIN  ：极高，系统管理、命名空间、挂载等（避免授予）
#         SYS_PTRACE ：中等，调试进程、strace
#         NET_ADMIN  ：中等，修改网络配置
#         IPC_OWNER  ：较低，绕过共享内存权限检查
