#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

modules=(
bin
git
tmux
vim
zsh
cpp
python
)

./install_config.sh ${modules[@]}

env='export is_server=true'
localrc=~/.zsh_local
[[ -f $localrc ]] && grep "$env" $localrc >/dev/null || echo $env >> $localrc
