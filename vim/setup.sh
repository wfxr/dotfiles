#!/bin/bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd $SCRIPT_DIR
mkdir -p ~/.vim ~/.config

ln -sf  $SCRIPT_DIR/vimrc              ~/.vimrc
ln -sf  $SCRIPT_DIR/gvimrc             ~/.gvimrc
ln -sf  $SCRIPT_DIR/vim_comm           ~/.vim_comm
ln -sf  $SCRIPT_DIR/vim_plug           ~/.vim_plug
ln -sf  $SCRIPT_DIR/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -snf $SCRIPT_DIR/UltiSnips          ~/.vim/UltiSnips

# nvim
ln -snf ~/.vim   ~/.config/nvim
ln -sf  ~/.vimrc ~/.config/nvim/init.vim

# Install plugins managed by vim-plug
# `tty &>/dev/null` is to make sure the script is run from a tty(ie, not ssh)
tty &>/dev/null && hash vim  &>/dev/null && vim  +PlugInstall +qall
tty &>/dev/null && hash nvim &>/dev/null && nvim +PlugInstall +qall
