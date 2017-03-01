#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.config/tilda

if [[ -a ~/.config/tilda/config_0 ]]; then
    mv ~/.config/tilda/config_0 ~/.config/tilda/config_0.bak
fi

ln -sf $script_dir/config ~/.config/tilda/config_0
