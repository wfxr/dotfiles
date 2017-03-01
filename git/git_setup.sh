#!/bin/bash

git config --global user.name "Wenxuan"
current_email=$(git config --global --get user.email)

git config --global github.user wfxr

# if current_email is empty, then add it
if [[ -z "$current_email" ]]; then
    git config --global user.email "wenxuan-zhang@outlook.com"
fi

git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

git config --global color.ui true

git config --global diff.tool kdiff3
git config --global difftool.prompt false
git config --global merge.tool kdiff3

# avoid enter password again and again
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
