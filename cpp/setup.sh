#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SCRIPT_DIR/ycm_extra_conf.py" ~/.ycm_extra_conf.py
ln -sf "$SCRIPT_DIR/clang-format"      ~/.clang-format
[[ -f ~/.gdbinit ]] || wget -P ~ git.io/.gdbinit

# CLI cpp reference
sudo -H pip install --upgrade pygments
sudo -H pip install --upgrade cppman
