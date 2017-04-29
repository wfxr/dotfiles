#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.vim/autoload
if [[ ! -a ~/.vim/autoload/plug.vim ]]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ln -sf $script_dir/vimrc ~/.vimrc
ln -sf $script_dir/vimrc_gui ~/.vimrc_gui
ln -sf $script_dir/vimrc_common ~/.vimrc_common
ln -sf $script_dir/vimrc_plugin ~/.vimrc_plugin
ln -sf $script_dir/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -snf $script_dir/UltiSnips ~/.vim/UltiSnips

# nvim
mkdir -p ~/.config
ln -snf ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim
