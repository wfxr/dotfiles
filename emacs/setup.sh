#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ ! -a ~/.emacs.d || ! -a ~/.emacs.d/spacemacs.mk ]]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

if [[ -a ~/.spacemacs ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -sf $script_dir/emacs/spacemacs ~/.spacemacs
