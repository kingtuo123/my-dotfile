#!/bin/bash

system_font=`fc-list | grep -v $HOME | cut -d : -f 2 | sed 's/^ /\t/g ' | sed 's/,/\n\t/g' | sort | uniq`
user_font=`fc-list | grep $HOME | cut -d : -f 2 | sed 's/^ /\t/g ' | sed 's/,/\n\t/g' | sort | uniq`


echo "System Font:"
echo "$system_font"
echo ""
echo "User Font:"
echo "$user_font"
