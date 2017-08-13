#!/usr/bin/env bash

cd $HOME
mkdir -p backups

src=(
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
[ $# -gt 0 ] && target=$1 || target=backups/dotdata-backups.tgz

echo Files to be backup:
printf '    %s\n' ${src[@]/#/$HOME/}
echo

echo Target file:
printf '    %s\n' $HOME/$target
echo

echo Progress:
tar cf - ${src[@]} -P | pv -s $(du -csb ${src[@]} | tail -1 | awk '{print $1}') | gzip > $target
