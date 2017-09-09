#!/usr/bin/env bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/zshrc        ~/.zshrc
ln -sf $script_dir/zsh_env      ~/.zsh_env
ln -sf $script_dir/zsh_aliases  ~/.zsh_aliases
ln -sf $script_dir/zsh_keybinds ~/.zsh_keybinds
ln -sf $script_dir/zsh_misc     ~/.zsh_misc
ln -sf $script_dir/zsh_custom   ~/.zsh_custom
ln -sf $script_dir/zsh_plug     ~/.zsh_plug

ln -sf $script_dir/completions/_ag  ~/.zplug/misc/completions/_ag
ln -sf $script_dir/completions/_pet ~/.zplug/misc/completions/_pet
ln -sf $script_dir/completions/_jq  ~/.zplug/misc/completions/_jq
ln -sf $script_dir/completions/_fzf ~/.zplug/misc/completions/_fzf

[[ $SHELL =~ "zsh" ]] || chsh -s `which zsh`
