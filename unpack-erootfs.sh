#!/bin/bash

echo "unpacking erootfs archives..."

SWITCH=0
BRANCH=""

if [ ! -d erootfs.minetest ]; then
	BRANCH=`git symbolic-ref -q HEAD`
	BRANCH=${BRANCH##refs/heads/}
	BRANCH=${BRANCH:-HEAD}
	echo $BRANCH

	# switch branches for erootfs archive
	if [ $BRANCH != "erootfs-archive" ]; then
		echo "switching from branch = $BRANCH"
		git checkout erootfs-archive
		SWITCH=1
	fi
fi

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

if [ $SWITCH -eq 1 ]; then
	echo "switching back to branch $BRANCH"
	git checkout $BRANCH
fi

exit $?

