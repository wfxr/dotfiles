#!/usr/bin/env bash
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1
set -euo pipefail

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

# https://github.com/neovim/neovim/wiki/Installing-Neovim
install_nvim() {
    if hash apt 2>/dev/null; then
        if ! (sudo apt update && sudo apt install neovim -y); then
            loginfo "failed installing neovim from package manager. try nvim.appimage instead..."
            mkdir -p ~/bin
            curl -fL -o /tmp/nvim \
                https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
            chmod u+x /tmp/nvim
            mv /tmp/nvim ~/bin/nvim
        fi
    elif hash pacman 2>/dev/null; then
        sudo pacman --noconfirm -Sy neovim
    elif hash brew 2>/dev/null; then
        sudo brew install neovim
    fi
}

setup_config() {
    mkdir -p ~/.config ~/.vim/spell

    ln -sf  "$SDIR/vimrc"              ~/.vimrc
    ln -sf  "$SDIR/gvimrc"             ~/.gvimrc
    ln -sf  "$SDIR/vim_map"            ~/.vim_map
    ln -sf  "$SDIR/vim_base"           ~/.vim_base
    ln -sf  "$SDIR/vim_plug"           ~/.vim_plug
    ln -sf  "$SDIR/spell/en.utf-8.add" ~/.vim/spell/en.utf-8.add
    ln -sf  "$SDIR/coc-settings.json"  ~/.vim/coc-settings.json
    ln -sf  "$HOME/.vimrc"             ~/.config/nvim/init.vim
    ln -snf "$SDIR/UltiSnips"          ~/.vim/UltiSnips
    ln -snf "$HOME/.vim"               ~/.config/nvim
    touch ~/.vim_local
}

hash nvim &>/dev/null || {
    loginfo "neovim not installed. install it now..."
    install_nvim
}

if hash pyenv &>/dev/null; then
    loginfo "install python dependency..."
    pip install --upgrade pynvim
    # For tags
    pip install --upgrade pygments
else
    logwarn "failed: pyenv not installed."
fi

if hash rbenv &>/dev/null; then
    loginfo "install ruby dependency..."
    gem install neovim
fi

if hash nodenv &>/dev/null; then
    loginfo "install node dependency..."
    npm install -g neovim
else
    logwarn 'maybe node not installed(coc.nvim need it).'
fi

loginfo "install vim plugins..."
nvim +PlugInstall +qall
