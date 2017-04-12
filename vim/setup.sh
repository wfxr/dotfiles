#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.config
mkdir -p ~/.vim/autoload

if [[ ! -a ~/.vim/autoload/plug.vim ]]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ -a ~/.vimrc ]]; then
  mv ~/.vimrc ~/.vimrc.bak
fi

if [[ -a ~/.vimrc_gui ]]; then
  mv ~/.vimrc_gui ~/.vimrc_gui.bak
fi

if [[ -a ~/.vimrc_common ]]; then
  mv ~/.vimrc_common ~/.vimrc_common.bak
fi

if [[ -a ~/.vimrc_plugin ]]; then
  mv ~/.vimrc_plugin ~/.vimrc_plugin.bak
fi

if [[ -a ~/.vim/spell ]]; then
  mv ~/.vim/spell ~/.vim/spell.bak
fi

if [[ -a ~/.vim/UltiSnips ]]; then
  mv ~/.vim/UltiSnips ~/.vim/UltiSnips.bak
fi

ln -sf $script_dir/vimrc ~/.vimrc
ln -sf $script_dir/vimrc_gui ~/.vimrc_gui
ln -sf $script_dir/vimrc_common ~/.vimrc_common
ln -sf $script_dir/vimrc_plugin ~/.vimrc_plugin
ln -sf $script_dir/spell ~/.vim/spell
ln -sf $script_dir/UltiSnips ~/.vim/UltiSnips

# nvim
ln -sf ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim
