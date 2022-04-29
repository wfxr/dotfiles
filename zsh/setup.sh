#!/usr/bin/env bash

info() { printf "$(date +%FT%T) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date +%FT%T) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date +%FT%T) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

ln -sf "$SDIR/zshrc"         ~/.zshrc
ln -sf "$SDIR/zshenv"        ~/.zshenv
ln -sf "$SDIR/zsh_misc"      ~/.zsh_misc
ln -sf "$SDIR/zsh_aliases"   ~/.zsh_aliases
ln -sf "$SDIR/zsh_custom"    ~/.zsh_custom
ln -sf "$SDIR/zsh_fzf_extra" ~/.zsh_fzf_extra
ln -sf "$SDIR/zsh_secret"    ~/.zsh_secret

hash starship &>/dev/null || warn "starship (shell theme) not installed."

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"

DISABLE_ZSH_DEFER=true zsh -ic 'exit'

# zsh source order:
# https://medium.com/@rajsek/zsh-bash-startup-files-loading-order-bashrc-zshrc-etc-e30045652f2e
# +----------------+-----------+-----------+------+
# |                |Interactive|Interactive|Script|
# |                |login      |non-login  |      |
# +----------------+-----------+-----------+------+
# |/etc/zshenv     |    A      |    A      |  A   |
# +----------------+-----------+-----------+------+
# |~/.zshenv       |    B      |    B      |  B   |
# +----------------+-----------+-----------+------+
# |/etc/zprofile   |    C      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zprofile     |    D      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zshrc      |    E      |    C      |      |
# +----------------+-----------+-----------+------+
# |~/.zshrc        |    F      |    D      |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogin     |    G      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogin       |    H      |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogout      |    I      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogout    |    J      |           |      |
# +----------------+-----------+-----------+------+
