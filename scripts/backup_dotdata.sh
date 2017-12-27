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
.go
.wakatime.cfg
.gdbinit
dotfiles
bin
)

excludes=(
)

[ $# -gt 0 ] && target=$1 || target=backups/dotdata-backups.tgz

echo Files to be backup:
printf '    %s\n' ${src[@]/#/$HOME/}
echo

echo Files patterns ignored:
printf '    %s\n' ${excludes[@]}
echo

echo Target file:
printf '    %s\n' $HOME/$target
read -n1 -rp "Continue? [y/N] " res; echo
[[ ! $res =~ y|Y ]] && exit 1
echo

echo Progress:
tar cf - ${src[@]} ${excludes[@]/#/--exclude=} -P | pv -s $(du -csb ${src[@]} | tail -1 | awk '{print $1}') | gzip > $target
