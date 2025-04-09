#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

mkdir -p ~/.cargo
ln -snf "$SCRIPT_DIR/config.toml"  ~/.cargo/config.toml
ln -snf "$SCRIPT_DIR/rustfmt.toml" ~/.rustfmt.toml

if hash rustup &>/dev/null; then
    rustup update
else
    curl https://sh.rustup.rs -sSf |
        sh -s -- --no-modify-path -y --profile default -c \
        clippy \
        rust-src \
        rust-std \
        rustfmt \
        --default-toolchain nightly || exit 1
fi

mkdir -p ~/.config/zsh/completions/
rustup completions zsh       > ~/.config/zsh/completions/_rustup
rustup completions zsh cargo > ~/.config/zsh/completions/_cargo

cargo install --locked cargo-update # for checking and applying updates to installed executables
cargo install --locked cargo-expand
cargo install --locked cargo-udeps
cargo install --locked cargo-watch

# perf binary size
cargo install --locked cargo-bloat

cargo install --locked flamegraph
hash perf &>/dev/null || {
    echo "You may need to install the following dependencies on arch:"
    echo "linux-tools-meta"
}
