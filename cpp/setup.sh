#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SCRIPT_DIR/ycm_extra_conf.py" ~/.ycm_extra_conf.py
ln -sf "$SCRIPT_DIR/clang-format"      ~/.clang-format
[[ -f ~/.gdbinit ]] || wget -P ~ git.io/.gdbinit

# CLI cpp reference
sudo -H pip install pygments
sudo pacman -S cppman-git 2>/dev/null
