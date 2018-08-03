#!/bin/bash

echo "building minetest..."

if [ ! -d minetest ]; then
	git clone https://github.com/buildwithpiper/minetest.git -b piper3-crosscompile
fi

pushd minetest
cmake . -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake \
	-DCMAKE_INSTALL_PREFIX=$EROOTFS/usr/share/minetest \
	-DRUN_IN_PLACE=1 -DBUILD_SERVER=0 \
	-DENABLE_LUAJIT=1 \
	-DLUA_INCLUDE_DIR=$EROOTFS/usr/include/luajit-2.0 \
	-DIRRLICHT_SOURCE_DIR=../../irrlicht/irrlicht/source/Irrlicht \
	-DIRRLICHT_INCLUDE_DIR=../../irrlicht/irrlicht/include \
	-DIRRLICHT_LIBRARY=../../irrlicht/irrlicht/lib/Linux/libIrrlicht.a \
	-DENABLE_GLES=0
make -j4
make install/strip
popd

exit $?

