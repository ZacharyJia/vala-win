#!/usr/bin/env bash

set -euxo pipefail

TRAVIS_OS_NAME=${1:-$TRAVIS_OS_NAME}
CXX=${CXX:-g++}

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
	choco install archiver
	mkdir -p "$VCPKG_ROOT"
	cd "$VCPKG_ROOT"
	curl --retry 5 --connect-timeout 30 --location --remote-header-name --output installed.zip "$VCPKG_CACHE_ZIP_URL"
	unzip -uo installed.zip > /dev/null
	./vcpkg.exe integrate install
	./vcpkg.exe install glib
else
	echo "not in this os"
fi