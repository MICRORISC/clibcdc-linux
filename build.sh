#!/bin/sh

MACHINE="$1"
BIN_DIR_NAME="`pwd`/bin/usr"

# if machine is empty default is arm
if [ "x$1" = "x" ]; then
	MACHINE="arm"
fi

BUILD_DIR_NAME=".build-$MACHINE"

if [ ! -d "$BUILD_DIR_NAME" ]; then
	mkdir "$BUILD_DIR_NAME"
fi

pushd "$BUILD_DIR_NAME"

echo "Configuring for $MACHINE"

if [ "$MACHINE" = "arm" ]; then
	cmake -DCMAKE_TOOLCHAIN_FILE=../RPI-cross.cmake ../ -DCMAKE_INSTALL_PREFIX:PATH="$BIN_DIR_NAME" -DMACHINE="${MACHINE}" || exit 1
elif [ "$MACHINE" = "x86" ]; then
	cmake -DCMAKE_TOOLCHAIN_FILE=../x86.cmake ../ -DCMAKE_INSTALL_PREFIX:PATH="$BIN_DIR_NAME" -DMACHINE="${MACHINE}" || exit 1
elif [ "$MACHINE" = "pc" ]; then
	cmake ../ -DCMAKE_INSTALL_PREFIX:PATH="$BIN_DIR_NAME" -DMACHINE="${MACHINE}" || exit 1
fi

# build
make -j4 || exit 1

# clear output
rm -r "$BIN_DIR_NAME_${MACHINE}"

# install binaries and libs
make install

popd

