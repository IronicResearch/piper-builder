#!/bin/bash

echo "cleaning ogg/vorbis libs..."

OGG_VERSION=1.3.2
VORBIS_VERSION=1.3.5

if [ -d libogg-$OGG_VERSION ]; then
	pushd libogg-$OGG_VERSION
	make clean
	popd
fi

if [ -d libvorbis-$VORBIS_VERSION ]; then
	pushd libvorbis-$VORBIS_VERSION
	make clean
	popd
fi

exit $?
