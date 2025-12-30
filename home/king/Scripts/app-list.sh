#!/bin/bash

if [[ $1 == "s" ]]; then
	cat /var/lib/portage/world | xargs -L 1 equery s
else
	cat /var/lib/portage/world
fi
