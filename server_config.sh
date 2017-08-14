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
grep $env ~/.zsh_local || echo $env >> ~/.zsh_local
