#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.cargo
ln -snf "$SCRIPT_DIR/config" ~/.cargo/config
ln -snf "$SCRIPT_DIR/rustfmt.toml" ~/.rustfmt.toml

hash rustup &>/dev/null || curl https://sh.rustup.rs -sSf | sh || exit 1
rustup update
rustup component add rls-preview rust-analysis rust-src rustfmt-preview

mkdir -p ~/.zsh_completions
rustup completions zsh > ~/.zsh_completions/_rustup
