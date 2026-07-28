#!/bin/bash

IMG="debian:trixie"

USE="rm wayland dbus dri machine-id net-host tmp home fonts"

SRC=""

DEP="sudo xwayland pciutils mesa-utils pipewire-audio fonts-dejavu fonts-wqy-microhei bash-completion"

CMD="/bin/bash"

function build_prepare {
    cat << EOF > /etc/apt/sources.list.d/debian.sources
Types: deb
URIs: http://mirrors.ustc.edu.cn/debian
Suites: trixie trixie-updates
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://mirrors.ustc.edu.cn/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

    cat << EOF >>  /etc/bash.bashrc
if [[ \$- != *i* ]] ; then
    return
fi
update_prompt() {
    if [[ \$? == 0 ]];then
        PS1='\[\e[1;32m\]:) '
    else
        PS1='\[\e[1;31m\]:( '
    fi
    PS1+='\[\e[1;31m\]\${BUILD_IMG:-CONTAINER} '
    PS1+='\[\e[1;34m\]\w '
    if [[ -v http_proxy ]];then
        PS1+='\[\e[1;33m\](proxy) '
    fi
    if [[ \$UID -eq 0 ]];then 
        PS1+='\[\e[1;31m\]\$ '
    else
        PS1+='\[\e[1;32m\]\$ '
    fi
    PS1+='\[\e[0m\]'
}
PROMPT_COMMAND=update_prompt
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:ignoredups
alias  l='ls --color -lh'
alias ll='ls --color -lha'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
bind '"\C-d":"\C-u\C-d"'
bind '"\C-p":history-search-backward'
bind '"\C-n":history-search-forward'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[Z": menu-complete-backward'
bind '"\e\e":"\C-asudo \C-e"'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'set completion-ignore-case on'
bind 'TAB: menu-complete'
EOF

    useradd -m -s /bin/bash -u ${BUILD_UID} ${BUILD_USER}
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    apt update
}

function build_config {
    echo "${BUILD_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}
