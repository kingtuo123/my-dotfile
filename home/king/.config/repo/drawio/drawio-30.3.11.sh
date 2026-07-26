#!/bin/bash

USE="wayland dbus dri machine-id net-host tmp home fonts shm-size=2g cap-add=SYS_ADMIN"

SRC="https://github.com/jgraph/drawio-desktop/releases/download/v${PV}/drawio-amd64-${PV}.deb"

DEP=""

CMD="/usr/local/bin/start.sh"

function build_config {
    echo "/usr/bin/drawio --disable-features=WaylandWpColorManagerV1 --force-color-profile=srgb --enable-features=UseOzonePlatform --ozone-platform=wayland" > /usr/local/bin/start.sh
    chmod +x /usr/local/bin/start.sh
}
