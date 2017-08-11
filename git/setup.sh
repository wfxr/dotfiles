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

# This makes sure that push pushes only the current branch, and pushes it to the
# same branch pull would pull from
git config --global push.default upstream

# This converts CRLF endings to LF endings on Mac & Lin and also keeps them in
# the repo, but for Windows checkouts it converts LF to CRLF (and back to LF on
# commits)
git config --global core.autocrlf input

# When editing the commit message, git will now always include a diff of the
# changes below the message area (the diff does NOT become part of the commit
# message, it's only there for information).
git config --global commit.verbose true

# Number of concurrent submodule fetches
git config --global submodule.fetchJobs 8

# Prettier diffs
git config --global diff.compactionHeuristic true
git config --global diff.indentHeuristic on

# diff-so-fancy
git config --global color.ui true

git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta "227"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "227 bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
