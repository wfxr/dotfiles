#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [[ ! -a ~/.emacs.d || ! -a ~/.emacs.d/spacemacs.mk ]]; then
    git clone --depth=1 https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

ln -sf "$SCRIPT_DIR/spacemacs" ~/.spacemacs
