#!/bin/bash

echo "cleaning irrlicht..."

if [ -d irrlicht ]; then
	pushd irrlicht/source/Irrlicht
	make clean
	rm ../../lib/Linux/*
	popd
fi

exit $?
