#!/bin/bash

echo "cleaning mpv libs..."

if [ -d ffmpeg ]; then
	pushd ffmpeg
	make clean
	popd
fi

if [ -d mpv ]; then
	pushd mpv
	./waf clean
	popd
fi

exit $?
