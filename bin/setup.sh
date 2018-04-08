#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p ~/bin

for file in *; do
    ln -sf "$SCRIPT_DIR/$file" "$HOME/bin/$file"
done
