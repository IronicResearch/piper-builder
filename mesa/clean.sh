#!/bin/bash

echo "cleaning mesa..."

if [ -d drm ]; then
	pushd drm
	make clean
	popd
fi

if [ -d mesa ]; then
	pushd mesa
	make clean
	popd
fi

exit $?
