#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

../gpg/setup.sh

./setup_core.sh

../zsh/setup.sh
../tmux/setup.sh

../sdk/python/setup.sh
../sdk/node/setup.sh
../vim/setup.sh

./setup_gui.sh

../git/setup.sh
