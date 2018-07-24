#!/bin/bash

echo "building ogg/vorbis libs..."

OGG_VERSION=1.3.2
VORBIS_VERSION=1.3.5

if [ ! -d libogg-$OGG_VERSION ]; then
	wget http://downloads.xiph.org/releases/ogg/libogg-$OGG_VERSION.tar.gz
	tar -xzvf libogg-$OGG_VERSION.tar.gz
fi

echo "building ogg libs..."

pushd libogg-$OGG_VERSION
./configure --host=arm-linux --prefix=$EROOTFS/usr
make -j4
make install
popd

if [ ! -d libvorbis-$VORBIS_VERSION ]; then
	wget http://downloads.xiph.org/releases/vorbis/libvorbis-$VORBIS_VERSION.tar.gz
	tar -xzvf libvorbis-$VORBIS_VERSION.tar.gz
fi

echo "building vorbis libs..."

pushd libvorbis-$VORBIS_VERSION
./configure --host=arm-linux --prefix=$EROOTFS/usr
make -j4
make install
popd

exit $?
