#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/tmux.conf ~/.tmux.conf

if [[ `uname` == *Darwin* ]]
then
    ln -sf $script_dir/tmux_osx.conf ~/.tmux_osx.conf
fi

# tpm
if [[ ! -a ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# tmuxinator
ln -snf $script_dir/tmuxinator ~/.tmuxinator
