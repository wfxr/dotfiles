#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ -a ~/.ideavimrc ]]; then
    mv ~/.ideavimrc ~/.ideavimrc.bak
fi

ln -sf $script_dir/ideavimrc ~/.ideavimrc

config_dir=~/.IntelliJIdea2016.3

if [[ -a $config_dir/config ]]
then
    mv $config_dir/config $config_dir/config.bak
fi

mkdir -p $config_dir
ln -sf $script_dir/config $config_dir/config
