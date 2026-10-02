export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:ignoredups


update_prompt() {
    if [[ $? == 0 ]];then
        PS1='\[\e[1;32m\]:) '
    else
        PS1='\[\e[1;31m\]:( '
    fi

    if [[ $UID -eq 0 ]];then
        PS1+='\[\e[1;31m\]docker\[\e[1;30m\]@\[\e[1;31m\]\u '
    else
        PS1+='\[\e[1;37m\]docker\[\e[1;30m\]@\[\e[1;37m\]\u '
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


source /etc/profile.d/bash_completion.sh
