#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.config

if [[ -a ~/.zshrc ]]; then
  mv ~/.zshrc ~/.zshrc.bak
fi

if [[ -a ~/.zshrc_theme_extra ]]; then
  mv ~/.zshrc_theme_extra ~/.zshrc_theme_extra.bak
fi

ln -s $script_dir/zsh/zshrc ~/.zshrc
ln -s $script_dir/zsh/zshrc_theme_extra ~/.zshrc_theme_extra

# zsh - antigen
mkdir -p ~/.antigen

if [[ ! -a ~/.antigen/antigen ]]; then
  git clone https://github.com/zsh-users/antigen.git ~/.antigen/antigen
fi

# vim
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

ln -s $script_dir/vim/vimrc ~/.vimrc
ln -s $script_dir/vim/vimrc_gui ~/.vimrc_gui
ln -s $script_dir/vim/vimrc_common ~/.vimrc_common
ln -s $script_dir/vim/vimrc_plugin ~/.vimrc_plugin

# nvim
ln -sf ~/.vim ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim

# emacs
if [[ -a ~/.spacemacs ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi
ln -s $script_dir/emacs/spacemacs ~/.spacemacs

if [[ ! -a ~/.emacs.d || ! -a ~/.emacs.d/spacemacs.mk ]]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

# tmux
if [[ -a ~/.tmux.conf ]]; then
  mv ~/.tmux.conf ~/.tmux.conf.bak
fi

ln -s $script_dir/tmux/tmux.conf ~/.tmux.conf

# tmux - tpm
if [[ ! -a ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# bin
mkdir -p $HOME/bin

$script_dir/git/git_setup.sh
$script_dir/clojure/clojure_setup.sh
$script_dir/c++/c++_setup.sh
