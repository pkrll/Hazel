#!/bin/bash

export SWIFT_VERSION=swift-4.1.1-RELEASE
  curl -O https://swift.org/builds/swift-4.1.1-release/xcode/${SWIFT_VERSION}/${SWIFT_VERSION}-osx.pkg
sudo installer -pkg ${SWIFT_VERSION}-osx.pkg -target /
export TOOLCHAINS=swift
