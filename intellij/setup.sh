#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/ideavimrc ~/.ideavimrc

config_dir=~/.IntelliJIdea2016.3

mkdir -p $config_dir
ln -sf $script_dir/config $config_dir/config
