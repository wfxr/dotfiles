#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.gradle
ln -sf "$SCRIPT_DIR/init.gradle" ~/.gradle/init.gradle
