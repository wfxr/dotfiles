#!/bin/bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

mkdir -p ~/.vim/spell ~/.config

ln -sf  "$SCRIPT_DIR/vimrc"              ~/.vimrc
ln -sf  "$SCRIPT_DIR/gvimrc"             ~/.gvimrc
ln -sf  "$SCRIPT_DIR/vim_map"            ~/.vim_map
ln -sf  "$SCRIPT_DIR/vim_base"           ~/.vim_base
ln -sf  "$SCRIPT_DIR/vim_plug"           ~/.vim_plug
ln -sf  "$SCRIPT_DIR/spell/en.utf-8.add" ~/.vim/spell/en.utf-8.add
ln -snf "$SCRIPT_DIR/UltiSnips"          ~/.vim/UltiSnips

# Install plugins managed by vim-plug
# `tty &>/dev/null` is to make sure the script is run from a tty(ie, not ssh)
tty &>/dev/null && vim +PlugInstall +qall

# nvim
if hash nvim &>/dev/null ; then
    ln -snf ~/.vim   ~/.config/nvim
    ln -sf  ~/.vimrc ~/.config/nvim/init.vim
    hash gem  &>/dev/null && gem install neovim
    hash pip2 &>/dev/null && pip2 install --upgrade neovim
    hash pip3 &>/dev/null && pip3 install --upgrade neovim
    tty &>/dev/null && nvim +PlugInstall +qall
fi

# For tags
pip install --upgrade pygments

# For vim-keysound
# sudo yaourt -S sdl sdl2_mixer
pip install --upgrade pysdl2
