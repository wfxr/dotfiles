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

echo export is_server=true > ~/.zsh_local
