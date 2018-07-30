#!/bin/bash

echo "unpacking erootfs archives..."

if [ ! -d erootfs.minetest ]; then
	tar -xzvf archive/erootfs.minetest.lib.tar.gz
	tar -xzvf archive/erootfs.minetest.usr.include.tar.gz
	tar -xzvf archive/erootfs.minetest.usr.lib.arm.tar.gz
fi

if [ ! -d erootfs ]; then
	ln -s erootfs.minetest erootfs
fi

exit $?

