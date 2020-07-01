#!/usr/bin/env bash

set -euxo pipefail

TRAVIS_OS_NAME=${1:-$TRAVIS_OS_NAME}
CXX=${CXX:-g++}

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
	choco install archiver
	cd /c/
	if [ -f "$VCPKG_ROOT/vcpkg.exe" ];then
		echo "cache hit, will not install vcpkg again"
		cd "$VCPKG_ROOT"
	else
		git clone --depth=1 https://github.com/Microsoft/vcpkg.git
		cd "$VCPKG_ROOT"
		./bootstrap-vcpkg.bat
	fi
	./vcpkg.exe install glib
	./vcpkg.exe integrate install
else
	echo "not in this os"
fi