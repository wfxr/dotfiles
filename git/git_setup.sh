#!/bin/bash

git config --global user.name "Wenxuan"
current_email=$(git config --global --get user.email)

git config --global github.user wfxr

# if current_email is empty, then add it
if [[ -z "$current_email" ]]; then
    git config --global user.email "wenxuangm@gmail.com"
fi

git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

git config --global color.ui true

# Seems not work on new version of git
git config --global diff.tool kdiff3
git config --global merge.tool kdiff3
if [[ $(uname) == *Darwin* ]]; then
    git config --global --add difftool.kdiff3.path /Applications/kdiff3.app/Contents/MacOS/kdiff3
    git config --global --add mergetool.kdiff3.path /Applications/kdiff3.app/Contents/MacOS/kdiff3
fi
git config --global difftool.prompt false

# Prettier diffs
git config --global diff.compactionHeuristic true
git config --global diff.indentHeuristic on

# avoid enter password again and again
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
