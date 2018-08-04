# piper-builder
builder template for piper3 components

This project repo is hosting builders for Piper3 components, including Minetest app,
Piper extensions, Mineclone2-based game, and support libraries.

Each component has a subdirectory for pulling down respective repos or archives, and
a build.sh script. The entire buildroot-style tree is traversed by the main build.sh
script at the parent directory, building and deploying components into an erootfs image.

	$ ./build.sh

The core erootfs image is generated from archives stored in a separate archive branch
meant to isolate large pulldowns. There are probably better ways for hosting such
large archive files, though are included in the erootfs-archive branch for completeness,
so initial pulldown may seem delayed. This is called by the main builder, though may be
invoked manually whenever the erootfs image needs to be regenerated from scratch.

	$ ./unpack-erootfs.sh

The host packages needed for the builders are listed in 'host-packages', and will get
automatically installed on the main build.sh first run. Will need 'sudo' credentials for
installing the host packages via the Linux package manager.

The main host tool is the ARM cross compiler, and will need some environment variables
set via 'set-env.sh' script. Some of the builders use additional cross-compilation
settings, like minetest toolchain.cmake config file. If you need to build just one
component, you'll need to set env vars manually at the parent directory first.

	$ . ./set-env.sh

Note this is done at the project root directory in order to locate the erootfs path
via the $EROOTFS env var. This is always invoked by the main build.sh builder.

Specific ARM settings for the Cortex-A53 CPU on the RaspberryPi3 are preset by env vars
for optimizing Piper Minetest and support libraries Irrlicht, Mesa/DRM/VC4, mpv/ffmpeg,
and Ogg/Vorbis. Refer to $ARMOPTS, $CFLAGS, $CXXFLAGS, etc.

A complete Minetest package with Piper mods, game, and world is created after all the
components are built. The individual package step is within the minetest subdirectory.

	$ cd minetest
	$ ./package.sh

Cleaning the build is done by the corresponding clean.sh scripts for each component,
invoked either individually or for the entire build tree.

	$ ./clean.sh

Tested cross compilation and host package installation on various Ubuntu 16 distros,
including Ubuntu 16.04.4 Server edition.
