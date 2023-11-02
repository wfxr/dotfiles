#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/.config

ln -snf "$SDIR/nvim"      ~/.config/nvim
ln -sf  "$SDIR/ideavimrc" ~/.ideavimrc
