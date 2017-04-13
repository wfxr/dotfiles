#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/zshrc ~/.zshrc
ln -sf $script_dir/zshrc_theme_extra ~/.zshrc_theme_extra

# zsh - antigen
mkdir -p ~/.antigen

if [[ ! -a ~/.antigen/antigen ]]; then
  git clone https://github.com/zsh-users/antigen.git ~/.antigen/antigen
fi

