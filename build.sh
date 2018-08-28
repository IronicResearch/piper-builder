#!/bin/bash

# low-budget builder for piper3 components

# get build target option, default = all targets
TARGET="all"
if [ "$1" != "" ]; then
	TARGET=$1
fi

# environment setup
. ./set-env.sh

# compiler check
RESULT=`which $CC`
RESULT=$?
echo "$CC returned $RESULT"
RESULT=`which $CXX`
RESULT=$?
echo "$CXX returned $RESULT"

# package check
if [ $RESULT -ne 0 ]; then
	./install-host-packages.sh
fi

# erootfs check
if [ ! -d erootfs ]; then
	./unpack-erootfs.sh
fi

# build components
RESULT=-22
PACKAGES=( "irrlicht" "minetest" "mesa" "vorbis" "mpv" )
for p in ${PACKAGES[@]} 
do
    if [ $p == $TARGET -o $TARGET == "all" ]; then
	echo $p
	pushd $p
	./build.sh
	RESULT=$?
	popd
    fi
done

if [ $RESULT -ne 0 ]; then
	echo "error building target=$TARGET, result=$RESULT"
	exit $RESULT
fi

# package components
if [ $RESULT -eq 0 -a $TARGET == "minetest" -o $TARGET == "all" ]; then
	pushd minetest
	./package.sh
	mv minetest.tar.gz ..
	popd
fi

echo "done building target=$TARGET, result=$RESULT"

exit $RESULT

