#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SCRIPT_DIR/ideavimrc" ~/.ideavimrc

#config_dir=~/.IntelliJIdea2016.3

#mkdir -p $config_dir
#ln -sf $script_dir/config $config_dir/config
