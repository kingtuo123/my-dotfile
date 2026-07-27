#!/bin/bash

timestamp=$(</var/db/repos/gentoo/metadata/timestamp.chk)

target=$(date -d "$timestamp" +%s)
now=$(date +%s)

diff_seconds=$((target - now))
diff_days=$((diff_seconds / 86400))

echo -e "\n仓库更新于 ${diff_days#-} 天前\n"
