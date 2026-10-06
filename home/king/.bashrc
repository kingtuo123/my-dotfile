# 如果当前 shell 不是交互式（interactive）的，就直接返回
if [[ $- != *i* ]] ; then
    return
fi



# history 命令输出的记录数量
export HISTSIZE=10000
# .bash_history 保存的历史命令数量
export HISTFILESIZE=1000000
# 不保存: 空格开头的命令; 忽略重复命令; 删除重复命令
export HISTCONTROL=ignorespace:ignoredups:erasedups
# 显示的末尾目录层数
# export PROMPT_DIRTRIM=4



update_prompt() {
    if [[ $? == 0 ]];then
        PS1='\[\e[1;32m\]:) '
    else
        PS1='\[\e[1;31m\]:( '
    fi

    if [[ $UID -eq 0 ]];then
        PS1+='\[\e[1;31m\]\u '
    else
        PS1+='\[\e[1;37m\]\u '
    fi

    PS1+='\[\e[1;34m\]\w '

    if [[ -v http_proxy ]];then
        PS1+='\[\e[1;33m\](proxy) '
    fi

    if [[ $UID -eq 0 ]];then
        PS1+='\[\e[1;31m\]\$ '
    else
        PS1+='\[\e[1;32m\]\$ '
    fi
    PS1+='\[\e[0m\]'
}
PROMPT_COMMAND=update_prompt



alias  l='ls --color -lh'
alias ll='ls --color -lha'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias re-source='source ~/.bashrc'
alias dmesg-check='dmesg | grep -i -e firmware -e fail -e error -e warn'
alias b="cd ~/Github/blog"
alias k="cd ~/Github/kingtuo123.github.io"
alias mhz="watch -n1 'grep -i Mhz /proc/cpuinfo | sort -nr -t: -k2'"
alias mpv-novideo='mpv --no-video --force-window=no --loop-file=inf'
alias swayimg="make -C ~/Container/swayimg dir=\$PWD"




# 终端代理
function pon(){
    history -w
    (
        proxy='http://192.168.20.120:7890'
        http_proxy=$proxy https_proxy=$proxy RSYNC_PROXY=$proxy bash
    )
    history -r
}



# Ctrl+d：Ctrl+u Ctrl+d -> 删除光标前到行首的所有内容，退出 shell
bind '"\C-d":"\C-u\C-d"'
# Ctrl+p：根据你当前已输入的前缀在历史记录中向后搜索
bind '"\C-p":history-search-backward'
# Ctrl+n：根据你当前已输入的前缀在历史记录中向前搜索
bind '"\C-n":history-search-forward'
# 上方向键：根据你当前已输入的前缀在历史记录中向后搜索
bind '"\e[A":history-search-backward'
# 下方向键：根据你当前已输入的前缀在历史记录中向前搜索
bind '"\e[B":history-search-forward'
# Tab：菜单补全
bind 'TAB: menu-complete'
# Alt+Tab：菜单补全向后选择
bind '"\e\t": menu-complete-backward'
# ESC+ESC：行首插入 sudo
bind '"\e\e":"\C-asudo \C-e"'
# 按 Tab 补全时，如果有多个候选，立即全部列出
bind 'set show-all-if-ambiguous on'
# 菜单补全时显示公共前缀
bind 'set menu-complete-display-prefix on'
# 补全时忽略大小写
bind 'set completion-ignore-case on'
# 补全时用不同颜色区分文件类型
bind "set colored-stats on"
# 用不同颜色高亮显示公共补全前缀
bind "set colored-completion-prefix on"



# 关闭终端对 Ctrl+S / Ctrl+Q 的软件流控制
stty -ixon
# 屏蔽 Ctrl+s 防止终端冻结
bind '"\C-s": ""'



# Alt + t 在当前目录打开新终端
alias newterm="bash -c 'swaymsg splitv && foot -D \$PWD &>/dev/null && swaymsg split none &>/dev/null &'"
bind -x '"\et":"newterm"'



# 终端 title 设置
case "$TERM" in
    foot*|alacritty*)
        set_title() {
            if [[ "$BASH_COMMAND" == "update_prompt" ]]; then
                echo -ne "\033]0;${USER:-bash} @ $(dirs)\007"
            elif [[ -n "$BASH_COMMAND" ]]; then
                echo -ne "\033]0;${BASH_COMMAND}\007"
            fi
        }
        trap 'set_title' DEBUG
    ;;
esac



# 加载 fzf
# Ctrl+R：模糊搜索历史命令
# Ctrl+T：模糊选择文件路径，直接粘贴到当前命令行
# Alt+C：模糊选择目录并直接 cd 进入
# 配合 ** 补全：输入 vim **<Tab>，会弹出 fzf 界面让你搜索文件再打开
if [[ -x "/usr/bin/fzf" ]]; then
    # 变量置空，仅使用 Ctrl+R 历史搜索命令
    FZF_CTRL_T_COMMAND= FZF_ALT_C_COMMAND= source <(fzf --bash)
fi
