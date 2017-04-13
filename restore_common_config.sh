#!/usr/bin/env bash

modules=(
'cpp'
'git'
'gradle'
'python'
'tmux'
'vim'
'zsh'
)

./restore_config.sh ${modules[@]}
