#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

target_dir="$HOME/.config/autokey/data"
mkdir -p "$target_dir"

rm -rf "$target_dir/My Phrases"
ln -snf $SCRIPT_DIR/phrases "$target_dir/My Phrases"
