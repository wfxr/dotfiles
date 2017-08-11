#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/bin

cd $script_dir
ls | grep -v `basename $0` | xargs -i{} ln -sf $script_dir/{} ~/bin/{}
