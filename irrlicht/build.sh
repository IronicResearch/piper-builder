#!/bin/bash

echo "building irrlicht..."

if [ ! -d irrlicht ]; then
	git fetch https://github.com/buildwithpiper/irrlicht.git release-1.8.4
fi

pushd irrlicht/source/Irrlicht
make NDEBUG=1 -j4
popd

exit $?

