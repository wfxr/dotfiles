#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.config/tilda

ln -sf $script_dir/config ~/.config/tilda/config_0
