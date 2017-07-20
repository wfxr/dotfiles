#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/zshrc        ~/.zshrc
ln -sf $script_dir/zsh_env      ~/.zsh_env
ln -sf $script_dir/zsh_aliases  ~/.zsh_aliases
ln -sf $script_dir/zsh_keybinds ~/.zsh_keybinds
ln -sf $script_dir/zsh_misc     ~/.zsh_misc
ln -sf $script_dir/zsh_custom   ~/.zsh_custom

chsh -s `which zsh`
