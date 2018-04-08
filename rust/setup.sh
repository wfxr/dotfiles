#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.cargo

ln -snf "$SCRIPT_DIR/config" ~/.cargo/config
