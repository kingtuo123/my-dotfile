#!/bin/bash

for repo in /var/db/repos/* ;do
    echo -en "\n"
    echo -en "\e[35m[$(basename $repo)]\e[0m"
    timestamp=$(<${repo}/metadata/timestamp.chk)

    target=$(date -d "$timestamp" +%s)
    now=$(date +%s)

    diff_seconds=$((target - now))
    diff_days=$((diff_seconds / 86400))

    echo -en "\n仓库更新于 ${diff_days#-} 天前\n"
done
echo -en "\n"
