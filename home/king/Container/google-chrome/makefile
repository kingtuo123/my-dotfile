image_name         := google-chrome

version            := 148.0.7778.215

deb_src            := https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_$(version)-1_amd64.deb

deb_path           := ./distdir/google-chrome-stable_$(version)-1_amd64.deb

run_cmd            :=

run_script         := ./start.sh

required_packages  :=

shm_size           := 2g

cap_add            := SYS_ADMIN

is_privileged      :=

is_x11             :=

is_map_fontsdir    :=

include ../common/common.mk




# shm_size 共享内存，单位 m、g。

# cap_add 容器内权限
#         SYS_ADMIN  ：极高，系统管理、命名空间、挂载等（避免授予）
#         SYS_PTRACE ：中等，调试进程、strace
#         NET_ADMIN  ：中等，修改网络配置
#         IPC_OWNER  ：较低，绕过共享内存权限检查
