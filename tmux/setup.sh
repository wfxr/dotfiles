#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p "$HOME/.config/tmux"
ln -sf "$SCRIPT_DIR/tmux.conf" "$HOME/.config/tmux/tmux.conf"

[[ $(uname) == *Darwin* ]] && ln -sf "$SCRIPT_DIR/tmux_osx.conf" ~/.tmux_osx.conf

# tmup
ln -sf "$SCRIPT_DIR/tmup.kdl" "$HOME/.config/tmux/tmup.kdl"

# install plugins
if command -v tmup >/dev/null 2>&1; then
    TMUP_BIN=$(command -v tmup)
else
    curl --proto '=https' --tlsv1.2 -LsSf https://raw.githubusercontent.com/wfxr/tmup/main/install.sh | sh
    TMUP_BIN="$HOME/.local/bin/tmup"
fi

"$TMUP_BIN" install
