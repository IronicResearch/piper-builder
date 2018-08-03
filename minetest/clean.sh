#!/bin/bash

echo "cleaning minetest..."

if [ -d minetest ]; then
	pushd minetest
	make clean
	popd
fi

if [ -d $EROOTFS/usr/share/minetest ]; then
	rm -rf $EROOTFS/usr/share/minetest
fi

exit $?

