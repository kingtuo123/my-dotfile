#!/bin/bash

if [[ -n $TMUX ]];then
	exit 1
fi

if [[ -z $1 ]];then
	tmux attach -t 0 || tmux new -s 0
else
	tmux attach -t $1 || tmux new -s $1
fi
