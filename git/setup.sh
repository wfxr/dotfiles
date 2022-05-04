#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

git config --global user.name "Wenxuan Zhang"
git config --global user.email "wenxuangm@gmail.com"
git config --global github.user "wfxr"
git config --global credential.username "wfxr"
git config --global color.ui true

# avoid entering password again and again
if [[ -z "${SSH_CLIENT-}" ]]; then
    case $OSTYPE in
        linux* )
            git config --global credential.helper libsecret
            ;;
        darwin* )
            git config --global credential.helper osxkeychain
    esac
fi

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

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "39"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "222 bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

# Auto rebase
git config --global pull.rebase true

git config --global color.status.added     green
git config --global color.status.updated   cyan
git config --global color.status.changed   red
git config --global color.status.untracked yellow

git config --global core.quotepath off

git config --global alias.root 'rev-parse --show-toplevel'
git config --global alias.lock '!git-crypt lock'
git config --global alias.unlock '!git-crypt unlock'

# signing
git config --global user.signingkey wenxuangm@gmail.com
git config --global commit.gpgsign true

# pre-commit https://pre-commit.com
hash pre-commit &>/dev/null && {
    mkdir -p ~/.config/git/template
    git config --global init.templateDir ~/.config/git/template &&
        pre-commit init-templatedir ~/.config/git/template
}

# Prettier diffs
git config --global diff.compactionHeuristic true
git config --global diff.indentHeuristic on

# Custom pager
# mkdir -p ~/bin
# ln -sf "$PWD/git-pager" ~/bin/git-pager

if hash delta &>/dev/null; then
    git config --global core.pager             'delta'
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate         'true'
    git config --global merge.conflictstyle    'diff3'
    git config --global diff.colorMoved        'default'
fi

# Political correctness?
git config --global init.defaultBranch main
