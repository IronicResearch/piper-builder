#!/bin/bash

echo "building mesa..."

if [ ! -d drm ]; then
	git clone git://anongit.freedesktop.org/mesa/drm.git -b master
	pushd drm
	git fetch git://anongit.freedesktop.org/mesa/drm.git 23e234a3503f51b9d9c585123d33b936f522808d
	git checkout 23e234a3503f51b9d9c585123d33b936f522808d
	./autogen.sh --host=arm-linux --prefix=$EROOTFS/usr
	popd
fi

echo "building mesa drm lib..."

pushd drm
./configure --host=arm-linux --prefix=$EROOTFS/usr --enable-vc4 --disable-intel --disable-radeon --disable-amdgpu --disable-nouveau --disable-vmwgfx --disable-freedreno
make -j4
make install
popd

if [ ! -d mesa ]; then
	git clone git://anongit.freedesktop.org/mesa/mesa.git -b 17.1
	pushd mesa
	patch -p1 < ../fix-mesa-hard-links.patch
	./autogen.sh --host=arm-linux --prefix=$EROOTFS/usr --with-gallium-drivers=vc4 --with-dri-drivers=  --with-egl-platforms=x11,drm
	popd
fi

echo "building mesa driver libs..."

pushd mesa
./configure --host=arm-linux --prefix=$EROOTFS/usr --with-gallium-drivers=vc4 --with-dri-drivers=  --with-egl-platforms=x11,drm --disable-xvmc
make -j4
make install
popd

${CROSS_COMPILE}strip ${EROOTFS}/usr/lib/lib*.so*
${CROSS_COMPILE}strip ${EROOTFS}/usr/lib/dri/*.so*

exit $?
