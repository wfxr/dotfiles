#!/bin/bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd $SCRIPT_DIR

ln -sf  $script_dir/vimrc              ~/.vimrc
ln -sf  $script_dir/gvimrc             ~/.gvimrc
ln -sf  $script_dir/vim_comm           ~/.vim_comm
ln -sf  $script_dir/vim_plug           ~/.vim_plug
ln -sf  $script_dir/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -snf $script_dir/UltiSnips          ~/.vim/UltiSnips

# nvim
mkdir -p ~/.config

ln -snf ~/.vim   ~/.config/nvim
ln -sf  ~/.vimrc ~/.config/nvim/init.vim

# vim-plug
[[ -a ~/.vim/autoload/plug.vim ]] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
tty &>/dev/null && hash vim  &>/dev/null && vim  +PlugInstall +qall
tty &>/dev/null && hash nvim &>/dev/null && nvim +PlugInstall +qall
