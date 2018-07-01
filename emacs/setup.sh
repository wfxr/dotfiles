#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [[ ! -a ~/.emacs.d || ! -a ~/.emacs.d/spacemacs.mk ]]; then
    git clone --depth=1 https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

ln -sf "$SCRIPT_DIR/spacemacs" ~/.spacemacs

# Systemd service
[[ -f ~/.config/systemd/user/emacs.service ]] && exit 0
mkdir -p ~/.config/systemd/user
ln -sf "$SCRIPT_DIR/emacs.service" ~/.config/systemd/user/emacs.service
systemctl --user daemon-reload
systemctl --user enable emacs
systemctl --user start  emacs
