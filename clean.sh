#!/bin/bash

# low-budget ∑cleaner for piper3 components

# environment setup
# . ./set-env.sh

# clean components
PACKAGES=( "irrlicht" "minetest" "mesa" "vorbis" "mpv" )
for p in ${PACKAGES[@]} 
do
	echo $p
	pushd $p
	./clean.sh
	RESULT=$?
	popd
done

echo "done cleaning, result=$RESULT"

exit $RESULT
