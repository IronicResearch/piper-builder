#!/bin/sh

# low-budget builder for piper3 components

# environment setup
. ./set-env.sh

# compiler check

# package check

# erootfs check

# build components
PACKAGES=( "irrlicht" "minetest" )
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

