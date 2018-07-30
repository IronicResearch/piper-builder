#!/bin/bash

# low-budget builder for piper3 components

# environment setup
. ./set-env.sh

# compiler check

# package check

# erootfs check
if [ ! -d erootfs ]; then
	./unpack-erootfs.sh
fi

# build components
PACKAGES=( "irrlicht" "minetest" "mesa" "vorbis" "mpv" )
for p in ${PACKAGES[@]} 
do
	echo $p
	pushd $p
	./build.sh
	RESULT=$?
	popd
done

# package components

echo "done building, result=$RESULT"

exit $RESULT

