#!/bin/bash

timestamp=$(</var/db/repos/gentoo/metadata/timestamp.chk)

target=$(date -d "$timestamp" +%s)
now=$(date +%s)

diff_seconds=$((target - now))
diff_days=$((diff_seconds / 86400))

[[ ${diff_days#-} -ge 15 ]] && color="#e67e80" || color="#d3c6aa"

printf '{"full_text":"   仓库更新于 %s 天前   ", "color":"%s"}\n' ${diff_days#-}  $color
