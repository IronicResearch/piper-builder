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
	make install/strip
	popd
fi

DEST=$EROOTFS/usr/share/minetest
mkdir -p $DEST/bin
mkdir -p $DEST/lib
mkdir -p $DEST/worlds
mkdir -p $DEST/clientmods

cp	piper-mods/minetest.conf 	$DEST
cp -Ra	piper-mods/piper-client/*	$DEST/clientmods
cp -RL	piper-mods/external/		$DEST/mods
cp -RL	piper-mods/piper/		$DEST/mods

# fixup for piper-mods/piper-client symlinks
pushd 	$DEST
ln -s	mods/piper			piper
popd

cp -R	mineclone2			$DEST/games
cp -R	mars-world/marsWorld-Latest	$DEST/worlds

cp -a	$EROOTFS/usr/lib/*.so*		$DEST/lib
cp -a	$EROOTFS/usr/lib/dri/*.so*	$DEST/lib
cp -a	minetest/minetest.sh		$DEST
cp -a	minetest/update.sh		$DEST

cp -a	LICENSE.libs.txt		$DEST/doc
cp -a	$EROOTFS/usr/lib/LICENSE.*	$DEST/doc

tar -czvf minetest.tar.gz -C $EROOTFS/usr/share/ minetest/ --exclude=.git*

exit $?

