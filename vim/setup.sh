#!/usr/bin/env bash
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1
set -eo pipefail

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

# https://github.com/neovim/neovim/wiki/Installing-Neovim
install_neovim() {
    hash nvim &>/dev/null && return
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

install_python_support() {
    if hash pip &>/dev/null; then
        pip install --upgrade pynvim
        # For tags
        pip install --upgrade pygments
    else
        logwarn "failed: pip not found."
    fi
}

install_ruby_support() {
    if hash gem &>/dev/null; then
        gem install neovim
    else
        logwarn "failed: gem not found."
    fi
}

install_node_support() {
    if hash npm &>/dev/null; then
        npm install -g neovim
    else
        logwarn "failed: npm not found."
    fi
}

install_configs() {
    mkdir -p ~/.config ~/.vim/spell

    ln -snf "$HOME/.vim"               ~/.config/nvim
    ln -sf  "$SDIR/vimrc"              ~/.config/nvim/init.vim
    ln -sf  "$SDIR/vimrc"              ~/.vimrc
    ln -sf  "$SDIR/gvimrc"             ~/.gvimrc
    ln -sf  "$SDIR/vim_map"            ~/.vim_map
    ln -sf  "$SDIR/vim_base"           ~/.vim_base
    ln -sf  "$SDIR/vim_plug"           ~/.vim_plug
    ln -sf  "$SDIR/spell/en.utf-8.add" ~/.vim/spell/en.utf-8.add
    ln -snf "$SDIR/UltiSnips"          ~/.vim/UltiSnips
    ln -sf  "$SDIR/coc-settings.json"  ~/.vim/coc-settings.json
    touch ~/.vim_local
}

install_plugins() {
    if ! hash node &>/dev/null; then
        loginfo "install node(coc.nvim need it)..."
        mkdir -p ~/local
        curl -fsSL https://install-node.now.sh/latest | bash -s -- --prefix="$HOME/.local" -y
    fi
    loginfo "install vim plugins..."
    nvim +PlugInstall +qall
}

loginfo "install neovim..."
install_neovim

loginfo "install python support..."
install_python_support

loginfo "install ruby support..."
[ "$DEV_RUBY" ] && install_ruby_support

loginfo "install node support..."
[ "$DEV_NODE" ] && install_node_support

loginfo "install configs..."
install_configs

loginfo "install plugins..."
install_plugins
