#!/usr/bin/env bash

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

confdir="$HOME/.config/zsh"
mkdir -p "$confdir"

ln -sf "$SDIR/zshrc"         ~/.zshrc
ln -sf "$SDIR/zshenv"        ~/.zshenv
ln -sf "$SDIR/zsh_misc"      "$confdir/zsh_misc"
ln -sf "$SDIR/zsh_aliases"   "$confdir/zsh_aliases"
ln -sf "$SDIR/zsh_custom"    "$confdir/zsh_custom"
ln -sf "$SDIR/zsh_fzf_extra" "$confdir/zsh_fzf_extra"
ln -sf "$SDIR/zsh_secret"    "$confdir/zsh_secret"

ln -sf "$SDIR/gruvbox-material-dark.zsh" "$confdir/gruvbox-material-dark.zsh"

rm -rf ~/.config/sheldon && ln -snf "$SDIR/sheldon" ~/.config/sheldon
ln -sf "$SDIR/starship.toml" ~/.config/starship.toml

[[ "$SHELL" =~ "zsh" ]] || chsh -s "$(command -v zsh)"

zsh -ic 'exit'

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
