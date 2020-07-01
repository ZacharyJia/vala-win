#!/usr/bin/env bash

set -euxo pipefail

curl --retry 5 --connect-timeout 30 --location --remote-header-name --output vala.tar.xz "$VALA_URL"
tar -xvf vala.tar.xz -C ./
ls
mkdir -p build && cd build
if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
	cmake .. -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake \
        -DVCPKG_TARGET_TRIPLET=$VCPKG_DEFAULT_TRIPLET \
        -DCMAKE_GENERATOR_PLATFORM=Win32 \
        -DCMAKE_BUILD_TYPE=$BUILD_CONFIG
else
    cmake .. -DCMAKE_BUILD_TYPE=$BUILD_CONFIG
fi
cmake --build . --config $BUILD_CONFIG --parallel 2