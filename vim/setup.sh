#!/usr/bin/env bash
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/.vim/spell ~/.config

touch ~/.vim_local
ln -sf "$SDIR/vimrc"    ~/.vimrc
ln -sf "$SDIR/gvimrc"   ~/.gvimrc
ln -sf "$SDIR/vim_map"  ~/.vim_map
ln -sf "$SDIR/vim_base" ~/.vim_base
ln -sf "$SDIR/vim_plug" ~/.vim_plug

ln -sf  "$SDIR/spell/en.utf-8.add" ~/.vim/spell/en.utf-8.add
ln -sf  "$SDIR/coc-settings.json"  ~/.vim/coc-settings.json
ln -snf "$SDIR/UltiSnips"          ~/.vim/UltiSnips

# Install plugins managed by vim-plug
# `tty &>/dev/null` is to make sure the script is run from a tty(ie, not ssh)
tty &>/dev/null && vim +PlugInstall +qall

# nvim
if hash nvim &>/dev/null ; then
    ln -snf ~/.vim   ~/.config/nvim
    ln -sf  ~/.vimrc ~/.config/nvim/init.vim
    hash gem  &>/dev/null && gem install neovim
    # hash pip2 &>/dev/null && pip2 install --upgrade pynvim
    hash pip3 &>/dev/null && pip3 install --upgrade pynvim
    tty &>/dev/null && nvim +PlugInstall +qall
fi

# For tags
hash pip &>/dev/null && pip install --upgrade pygments

# For vim-keysound
# sudo pacman -S sdl sdl2_mixer
# pip install --upgrade pysdl2
