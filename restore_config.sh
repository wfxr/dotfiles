#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.config
mkdir -p ~/bin

$script_dir/git/setup.sh
$script_dir/zsh/setup.sh
$script_dir/vim/setup.sh
$script_dir/tmux/setup.sh
$script_dir/c++/setup.sh
$script_dir/python/setup.sh
