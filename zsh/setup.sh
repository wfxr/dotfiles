#!/usr/bin/env bash

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

confdir="$HOME/.config/zsh"
mkdir -p "$confdir"

ln -sf "$SDIR/zshrc"  ~/.zshrc
ln -sf "$SDIR/zshenv" ~/.zshenv

ln -sf {"$SDIR","$confdir"}/zsh_misc
ln -sf {"$SDIR","$confdir"}/zsh_aliases
ln -sf {"$SDIR","$confdir"}/zsh_custom
ln -sf {"$SDIR","$confdir"}/zsh_fzf_extra
ln -sf {"$SDIR","$confdir"}/zsh_secret

for f in *.zsh; do
    ln -sf {"$SDIR","$confdir"}/"$f"
done

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
