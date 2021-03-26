#!/usr/bin/env bash

directory=.ghq/github.com/ryanoasis/
mkdir -p $directory && cd $directory || exit 1
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts || cd nerd-fonts || exit 1
git pull
nerd-fonts/install.sh
