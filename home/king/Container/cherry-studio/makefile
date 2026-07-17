image_name         := cherry-studio

version            := 1.9.12

deb_src            := https://github.com/CherryHQ/cherry-studio/releases/download/v$(version)/Cherry-Studio-$(version)-amd64.deb

deb_path           := ./distdir/Cherry-Studio-$(version)-amd64.deb

run_cmd            :=

run_script         := ./start.sh

required_packages  :=

shm_size           := 8g

cap_add            := SYS_ADMIN

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
