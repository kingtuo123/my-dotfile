#!/bin/bash

if $(incus list my-win10 --fast | grep 'RUNNING' -q); then
    incus console my-win10 --type=vga
else
    incus start my-win10 --console=vga
fi
