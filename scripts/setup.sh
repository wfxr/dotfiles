#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/scripts

for file in *; do
    ln -sf "$SCRIPT_DIR/$file" "$HOME/scripts/$file"
done
