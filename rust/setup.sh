#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.cargo
ln -snf "$SCRIPT_DIR/config" ~/.cargo/config
ln -snf "$SCRIPT_DIR/rustfmt.toml" ~/.rustfmt.toml

if hash rustup &>/dev/null; then
    rustup update
else
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --profile complete --default-toolchain nightly -y || exit 1
fi

# rustup component add rls-preview rust-analysis rust-src rustfmt-preview
mkdir -p ~/.zsh_completions
rustup completions zsh       > ~/.zsh_completions/_rustup
rustup completions zsh cargo > ~/.zsh_completions/_cargo
