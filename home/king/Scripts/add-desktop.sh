#!/bin/bash

dest="$HOME/.local/share/applications"

for app in "$@"; do
cat <<EOF >${dest}/${app}.desktop
[Desktop Entry]
Type=Application
Exec=make -C ~/Container/${app}
Name=${app@u}
EOF
done
