#!/usr/bin/env bash

modules=(
bin
git
tmux
vim
zsh
cpp
python
)

./custom_config.sh ${modules[@]}

env='export is_server=true'
localrc=~/.zsh_local
[[ -f $localrc ]] && grep "$env" $localrc >/dev/null || echo $env >> $localrc
