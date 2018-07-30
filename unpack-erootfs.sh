#!/bin/bash

echo "unpacking erootfs archives..."

if [ ! -d erootfs.minetest ]; then
	tar -xzvf archive/erootfs.minetest.lib.tar.gz
	tar -xzvf archive/erootfs.minetest.usr.include.tar.gz
	tar -xzvf archive/erootfs.minetest.usr.lib.arm.tar.gz
	tar -xzvf archive/erootfs-patch-x11.tar.gz -C erootfs.minetest
	tar -xzvf archive/erootfs-patch-pkg.tar.gz -C erootfs.minetest
	tar -xzvf archive/erootfs-patch-alsa.tar.gz -C erootfs.minetest
fi

if [ ! -d erootfs ]; then
	ln -s erootfs.minetest erootfs
fi

exit $?

