#!/bin/bash

# low-budget builder for piper3 components

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
	cat host-packages |
	while IFS=: read p
	do
		echo $p
		apt list $p
		RESULT=$?
		if [ $RESULT -ne 0 ]; then
			sudo apt install $p
		fi
	done
fi

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
if [ $RESULT -eq 0 ]; then
	pushd minetest
	./package.sh
	mv minetest.tar.gz ..
	popd
fi

echo "done building, result=$RESULT"

exit $RESULT

