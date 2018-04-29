#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

hash rustup &>/dev/null || curl https://sh.rustup.rs -sSf | sh || exit 1
hash rustfmt &>/dev/null || cargo install rustfmt
rustup component list | grep rust-src &>/dev/null || rustup component add rust-src

mkdir -p ~/.cargo

ln -snf "$SCRIPT_DIR/config" ~/.cargo/config
ln -snf "$SCRIPT_DIR/rustfmt.toml" ~/.rustfmt.toml
