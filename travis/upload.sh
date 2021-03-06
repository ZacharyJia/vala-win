#!/usr/bin/env bash

source ./.env

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    cp -r ./vapi ./build/Release
    ls ./build/Release
    arc archive vala-prebuilt-$VALAC_VERSION-x64.zip ./build/Release/*
    curl -F "file=@vala-prebuilt-$VALAC_VERSION-x64.zip" https://api.anonfiles.com/upload
else
	echo "not in this os"
fi
