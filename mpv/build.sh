#!/bin/bash

echo "building mpv libs..."

if [ ! -d ffmpeg ]; then
	git clone https://github.com/FFmpeg/FFmpeg.git -b release/4.0
fi

echo "building ffmpeg libs..."

pushd ffmpeg
./configure --prefix=$EROOTFS/usr --enable-cross-compile --cross-prefix=$CROSS_COMPILE --sysroot=$EROOTFS --arch=arm --target-os=linux --cpu=cortex-a53 --enable-vfp --enable-neon --enable-libdrm --enable-shared
make -j4
make install
popd

if [ ! -d mpv ]; then
	git clone https://github.com/mpv-player/mpv.git -b release/0.29
	pushd mpv
	./bootstrap.py
	popd
fi

echo "building mpv..."

pushd mpv
./waf configure --prefix=$EROOTFS/usr --enable-libmpv-shared --enable-drm --enable-openal --disable-libass --disable-wayland
./waf build -j4
./waf install
popd

exit $?

