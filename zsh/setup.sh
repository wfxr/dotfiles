#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1

ln -sf "$SCRIPT_DIR/zshenv"       ~/.zshenv
ln -sf "$SCRIPT_DIR/zshrc"         ~/.zshrc
ln -sf "$SCRIPT_DIR/zsh_aliases"   ~/.zsh_aliases
ln -sf "$SCRIPT_DIR/zsh_keybinds"  ~/.zsh_keybinds
ln -sf "$SCRIPT_DIR/zsh_misc"      ~/.zsh_misc
ln -sf "$SCRIPT_DIR/zsh_custom"    ~/.zsh_custom
ln -sf "$SCRIPT_DIR/zsh_plug"      ~/.zsh_plug
ln -sf "$SCRIPT_DIR/zsh_theme"     ~/.zsh_theme
ln -sf "$SCRIPT_DIR/zsh_fzf_extra" ~/.zsh_fzf_extra

mkdir -p ~/.zsh_completions
ln -sf "$SCRIPT_DIR/completions/_ag"  ~/.zsh_completions/_ag
ln -sf "$SCRIPT_DIR/completions/_pet" ~/.zsh_completions/_pet
ln -sf "$SCRIPT_DIR/completions/_jq"  ~/.zsh_completions/_jq
ln -sf "$SCRIPT_DIR/completions/_fzf" ~/.zsh_completions/_fzf
ln -sf "$SCRIPT_DIR/completions/_gi"  ~/.zsh_completions/_gi
ln -sf "$SCRIPT_DIR/completions/_hub" ~/.zsh_completions/_hub

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"
