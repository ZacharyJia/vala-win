#!/usr/bin/env bash

set -euxo pipefail

curl --retry 5 --connect-timeout 30 --location --remote-header-name --output vala.tar.xz "$VALA_URL"
arc unarchive vala.tar.xz ./
mv vala-0.48.7/* ./
ls
mkdir -p build && cd build
if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
	cmake .. -DVCPKG_TARGET_TRIPLET=$VCPKG_DEFAULT_TRIPLET \
        -DCMAKE_GENERATOR_PLATFORM=x64 \
        -DCMAKE_BUILD_TYPE=$BUILD_CONFIG
else
    cmake .. -DCMAKE_BUILD_TYPE=$BUILD_CONFIG
fi
cmake --build . --config $BUILD_CONFIG --parallel 2