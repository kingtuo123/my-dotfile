#!/bin/bash

if [[ -z $1 ]];then
    echo "需要参数"
    exit 0;
else
    origin="$1"
fi


if [[ -z $2 ]];then
    replace="$1"
else
    replace="$2"
fi


# 仅能手动指定一个文件
if [[ -z $3 ]];then
    files=""
else
    files=("$3")
fi


RED=$'\033[1;31m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[1;34m'
MAGENTA=$'\033[1;35m'
CYAN=$'\033[1;36m'
NC=$'\033[0m' # No Color


declare -a ignores
ignores+=("! -name *.svg          ")
ignores+=("! -name *.deb          ")
ignores+=("! -name *.zip          ")
ignores+=("! -name *.rar          ")
ignores+=("! -name *.tar.*        ")
ignores+=("! -path */.git/*       ")
ignores+=("! -path */.github/*    ")
ignores+=("! -path */.cache/*     ")
ignores+=("! -path */public/*     ")
ignores+=("! -path */drafts/*     ")
ignores+=("! -path */resources/*  ")
ignores+=("! -path */static/*     ")


if [[ -z "$files" ]];then
    files=($( find . ${ignores[@]} -type f -name "*.*" | xargs grep -r -F -e "${origin}" | cut -d: -f1 | sort -u ))
fi


if [[ ${#files[@]} -eq 0 ]];then
    echo "未匹配到文件"
    exit 0 
fi


for f in "${files[@]}"; do
    echo -e "${CYAN}$f${NC}"
    sed -n "s@${origin}@${replace}@gp" $f   |   sed -n "s@${replace}@${YELLOW}${replace}${NC}@gp"
    echo ""
done


if [[  "$origin" ==  "$replace" ]];then
    echo -e "${RED}仅查找${NC}\n"
    exit 0;
fi


echo sed -i "s@${origin}@${replace}@g" "${files[@]}"
echo ""


read -p "是否替换[y/N]: " answer


if [[ "${answer@L}" == 'y' ]];then
    echo -e "\n${GREEN}确认替换${NC}\n"
    sed -i "s@${origin}@${replace}@g" ${files[@]}
else
    echo -e "\n${RED}取消替换${NC}\n"
fi
