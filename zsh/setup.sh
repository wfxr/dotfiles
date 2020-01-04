#!/usr/bin/env bash

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SDIR/zshrc"         ~/.zshrc
ln -sf "$SDIR/zshenv"        ~/.zshenv
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

"$SDIR/../starship/setup.sh" || logwarn "shell theme starship not installed correctly."

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"

DISABLE_ZSH_DEFER=1 zsh -ic 'exit'
