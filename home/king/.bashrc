if [[ $- != *i* ]] ; then
	return
fi



# history 命令输出的记录数量
export HISTSIZE=1000
# .bash_history 保存的历史命令数量
export HISTFILESIZE=10000
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
alias sx='sway &>/tmp/sway.log'
alias xs='sway &>/tmp/sway.log'
alias mpc-update='( { cd ~/Music && mpc clear && mpc update; } &> /dev/null ; mpc listall | mpc add)'
alias mpv-novideo='mpv --no-video --force-window=no --loop-file=inf'
alias re-source='source ~/.bashrc'
alias dmesg-check='dmesg | grep -i -e firmware -e fail -e error -e warn'
alias screen-off='xset dpms force off'
alias sim="bash -c 'swaymsg splitv && swayimg -g && swaymsg split none &'"
alias t="bash -c 'swaymsg splitv && foot -D \$PWD &>/dev/null && swaymsg split none &'"
alias b="cd ~/Github/blog"
alias k="cd ~/Github/kingtuo123.github.io"



# Docker 容器
alias dk="docker ps -q | xargs docker kill 2>/dev/null || echo 'no container running'"
alias dl="make -C ~/Container/debian bash"
alias clash="make -C ~/Container/clash"
alias amberol="make -C ~/Container/amberol"
alias jwm="make -C ~/Container/jwm"
alias baidunetdisk="make -C ~/Container/baidunetdisk"
alias xunlei="make -C ~/Container/xunlei"
alias google-chrome="make -C ~/Container/google-chrome"
alias drawio="make -C ~/Container/drawio"
alias inkscape="make -C ~/Container/inkscape"



# 终端代理
function pon(){
	history -w
	(
		proxy='http://127.0.0.1:7897'
		http_proxy=$proxy https_proxy=$proxy RSYNC_PROXY=$proxy bash
	)
	history -r
}





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
bind -x '"\et":"t"'



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
