#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

modules=(
bin
git
tmux
vim
zsh
ruby
python
)

./install_config.sh "${modules[@]}"
