#!/usr/bin/env bash

[ $# -gt 0 ] && src=$1 || src=$HOME/backups/dotdata-backup.tgz
[ ! -f $src ]  && echo 'No backup file exist.' && exit 1

files=(`tar --exclude='*/*' -tf $src`)

cd $HOME

printf 'Following files will be restored(from %s):\n' ${src}
echo "    ${files[@]}"

read -n1 -rp "Continue? [y/N] " res; echo
[[ ! $res =~ y|Y ]] && exit 1

echo
echo Progress:
pv $src | tar zxf -
