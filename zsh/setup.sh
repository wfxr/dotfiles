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
ln -sf $script_dir/zsh_theme    ~/.zsh_theme

mkdir -p ~/.zsh_completions
ln -sf $script_dir/completions/_ag  ~/.zsh_completions/_ag
ln -sf $script_dir/completions/_pet ~/.zsh_completions/_pet
ln -sf $script_dir/completions/_jq  ~/.zsh_completions/_jq
ln -sf $script_dir/completions/_fzf ~/.zsh_completions/_fzf
ln -sf $script_dir/completions/_gi ~/.zsh_completions/_gi
ln -sf $script_dir/completions/_hub ~/.zsh_completions/_hub

[[ $SHELL =~ "zsh" ]] || chsh -s `which zsh`
