#!/bin/bash

echo "building minetest..."

if [ ! -d minetest ]; then
	git fetch https://github.com/buildwithpiper/minetest.git piper3-crosscompile
fi

pushd minetest
cmake . -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake \
	-DRUN_IN_PLACE=1 -DBUILD_SERVER=0 \
	-DENABLE_LUAJIT=1 \
	-DLUA_INCLUDE_DIR=$EROOTFS/usr/include/luajit-2.0 \
	-DIRRLICHT_SOURCE_DIR=irrlicht/source/Irrlicht \
	-DIRRLICHT_INCLUDE_DIR=irrlicht/include \
	-DIRRLICHT_LIBRARY=irrlicht/lib/Linux/libIrrlicht.a \
	-DENABLE_GLES=0
make -j4
popd

exit $?

