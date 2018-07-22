#!/bin/bash

echo "building irrlicht..."

pushd irrlicht/source/Irrlicht
make NDEBUG=1 -j4
popd

exit $?

