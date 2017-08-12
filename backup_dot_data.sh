#!/usr/bin/env bash

files=(
.vim
.zplug
.fzf
.fzf.bash
.fzf.zsh
.tmux
.gitconfig
.ssh
.wakatime.cfg
dotfiles
)

cd ~ && target=`pwd`/dotdata-backup.tgz
echo $target
tar cf - $files -P | pv -s $(du -sb $files | awk '{print $1}') | gzip > $target
