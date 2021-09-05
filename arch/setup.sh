#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

mkdir -p "$HOME/.config"
mkdir -p "$HOME/tmp"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/downloads"
mkdir -p "$HOME/documents"
mkdir -p "$HOME/music"
mkdir -p "$HOME/pictures"
mkdir -p "$HOME/videos"
mkdir -p "$HOME/screenshots"
mkdir -p "$HOME/develop"

mkdir -p ~/.config/paru
ln -sf "$SDIR/paru.conf" ~/.config/paru/paru.conf

../gpg/setup.sh

./setup_core.sh

git submodule update --init --recursive

../zsh/setup.sh
../tmux/setup.sh

../sdk/python/setup.sh
../sdk/node/setup.sh

../vim/setup.sh

../git/setup.sh

./setup_gui.sh
