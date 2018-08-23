#!/bin/bash

echo "building mpv libs..."

if [ ! -d ffmpeg ]; then
	git clone https://github.com/FFmpeg/FFmpeg.git -b release/4.0 ffmpeg
fi

echo "building ffmpeg libs..."

pushd ffmpeg
./configure --prefix=$EROOTFS/usr --enable-cross-compile --cross-prefix=$CROSS_COMPILE --sysroot=$EROOTFS \
	--arch=arm --target-os=linux --cpu=cortex-a53 --enable-vfp --enable-neon \
	--enable-libdrm --enable-shared \
	--disable-programs --disable-doc \
	--disable-encoders --disable-muxers --disable-indevs \
	--disable-filters --disable-protocols --disable-bsfs \
	--disable-parsers --disable-demuxers --disable-decoders \
	--enable-parser=aac,h264,mpeg4video,mpegaudio,vorbis \
	--enable-demuxer=aac,h264,mpeg4,mp3,ogg,wav,pcm_s16le,mov,aiff \
	--enable-decoder=aac,h264,mpeg4,mp3,vorbis,pcm_s16le \
	--enable-lzo \
	--disable-debug
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
./waf configure --prefix=$EROOTFS/usr --enable-libmpv-shared --enable-drm --enable-openal --disable-libass --disable-wayland --disable-pulse --disable-debug-build
./waf build -j4
./waf install
cp -a LICENSE.* ${EROOTFS}/usr/lib
popd

${CROSS_COMPILE}strip ${EROOTFS}/usr/lib/libav*.so*
${CROSS_COMPILE}strip ${EROOTFS}/usr/lib/libmpv*.so*

exit $?

