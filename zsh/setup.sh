#!/usr/bin/env bash

# get the dir of the current script
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

ln -sf "$SDIR/zshrc"         ~/.zshrc
ln -sf "$SDIR/zsh_env"       ~/.zsh_env
ln -sf "$SDIR/zsh_aliases"   ~/.zsh_aliases
ln -sf "$SDIR/zsh_keybinds"  ~/.zsh_keybinds
ln -sf "$SDIR/zsh_misc"      ~/.zsh_misc
ln -sf "$SDIR/zsh_custom"    ~/.zsh_custom
ln -sf "$SDIR/zsh_plug"      ~/.zsh_plug
# ln -sf "$SDIR/zsh_theme"     ~/.zsh_theme
ln -sf "$SDIR/zsh_fzf_extra" ~/.zsh_fzf_extra
ln -sf "$SDIR/zsh_secret"    ~/.zsh_secret

mkdir -p ~/.zsh_completions
ln -sf "$SDIR/completions/_ag"  ~/.zsh_completions/_ag
ln -sf "$SDIR/completions/_pet" ~/.zsh_completions/_pet
ln -sf "$SDIR/completions/_jq"  ~/.zsh_completions/_jq
ln -sf "$SDIR/completions/_fzf" ~/.zsh_completions/_fzf
ln -sf "$SDIR/completions/_gi"  ~/.zsh_completions/_gi
ln -sf "$SDIR/completions/_hub" ~/.zsh_completions/_hub

../starship/setup.sh

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"
