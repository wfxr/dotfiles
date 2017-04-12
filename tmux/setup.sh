#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ -a ~/.tmux.conf ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.bak
fi
ln -sf $script_dir/tmux.conf ~/.tmux.conf

if [[ `uname` == *Darwin* ]]
then
    if [[ -a ~/.tmux_osx.conf ]]; then
        mv ~/.tmux_osx.conf ~/.tmux_osx.conf.bak
    fi
    ln -sf $script_dir/tmux_osx.conf ~/.tmux_osx.conf
fi

# tmux - tpm
if [[ ! -a ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

