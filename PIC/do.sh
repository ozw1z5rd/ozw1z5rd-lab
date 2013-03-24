#!/bin/sh
gpasm -I /usr/share/gputils/header -I ./ $1.asm -a inhx32
