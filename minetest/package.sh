#!/bin/bash

echo "packaging minetest..."

if [ ! -d piper-mods ]; then
	git clone --depth 1 https://github.com/buildwithpiper/piper-mods.git -b piper3-mods-config
fi

if [ ! -d mineclone2 ]; then
	git clone --depth 1 https://github.com/buildwithpiper/mineclone2.git -b master
fi

if [ ! -d mars-world ]; then
	git clone --depth 1 https://github.com/buildwithpiper/mars-world.git -b master
fi

if [ ! -d $EROOTFS/usr/share/minetest ]; then
	pushd minetest
	make install
	popd
fi

DEST=$EROOTFS/usr/share/minetest
mkdir -p $DEST/bin
mkdir -p $DEST/lib
mkdir -p $DEST/worlds
mkdir -p $DEST/clientmods

cp	piper-mods/minetest.conf 	$DEST
cp -RL	piper-mods/piper-client/*	$DEST/clientmods
cp -RL	piper-mods/external/		$DEST/mods
cp -RL	piper-mods/piper/		$DEST/mods

cp -R	mineclone2			$DEST/games
cp -R	mars-world/marsWorld-Latest	$DEST/worlds

cp	$EROOTFS/usr/bin/minetest	$DEST/bin
cp -a	$EROOTFS/usr/lib/*.so*		$DEST/lib
cp -a	$EROOTFS/usr/lib/dri/*.so*	$DEST/lib
cp -a	minetest.sh			$DEST

tar -czvf minetest.tar.gz -C $EROOTFS/usr/share/ minetest/

exit $?

