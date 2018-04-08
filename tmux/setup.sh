#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

ln -sf "$SCRIPT_DIR/tmux.conf" ~/.tmux.conf

[[ $(uname) == *Darwin* ]] && ln -sf "$SCRIPT_DIR/tmux_osx.conf" ~/.tmux_osx.conf

# tpm
[[ ! -a ~/.tmux/plugins/tpm ]] && git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# tmuxinator
ln -snf "$SCRIPT_DIR/tmuxinator" ~/.tmuxinator
