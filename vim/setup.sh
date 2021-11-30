#!/usr/bin/env bash
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

info() { printf "$(date -Is) %b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "$(date -Is) %b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "$(date -Is) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

# https://github.com/neovim/neovim/wiki/Installing-Neovim
install_neovim() {
    hash nvim &>/dev/null && return
    mkdir -p ~/bin
    curl -fL -o /tmp/nvim \
        https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x /tmp/nvim
    mv /tmp/nvim ~/bin/nvim
}

install_python_support() {
    if hash pip &>/dev/null; then
        pip install --upgrade pynvim
        # For tags
        pip install --upgrade pygments
    else
        warn "failed: pip not found."
    fi
}

install_ruby_support() {
    if hash gem &>/dev/null; then
        gem install neovim
    else
        warn "failed: gem not found."
    fi
}

install_node_support() {
    if hash npm &>/dev/null; then
        npm install -g neovim
    else
        warn "failed: npm not found."
    fi
}

install_configs() {
    mkdir -p ~/.config ~/.vim/spell

    ln -snf "$HOME/.vim"               ~/.config/nvim
    ln -sf  "$SDIR/init.lua"           ~/.config/nvim/init.lua
    ln -sf  "$SDIR/vimrc"              ~/.vimrc
    ln -sf  "$SDIR/gvimrc"             ~/.gvimrc
    ln -sf  "$SDIR/vim_map"            ~/.vim_map
    ln -sf  "$SDIR/vim_base"           ~/.vim_base
    ln -sf  "$SDIR/vim_plug"           ~/.vim_plug
    ln -sf  "$SDIR/spell/en.utf-8.add" ~/.vim/spell/en.utf-8.add
    ln -snf "$SDIR/UltiSnips"          ~/.vim/UltiSnips
    ln -sf  "$SDIR/coc-settings.json"  ~/.vim/coc-settings.json
    touch ~/.vim_local

    ln -snf "$SDIR/lua" ~/.config/nvim/lua

    ln -sf  "$SDIR/ideavimrc" ~/.ideavimrc
}

install_plugins() {
    local plug_manager=~/.vim/autoload/plug.vim
    if ! [ -f "$plug_manager" ]; then
        mkdir -p ~/.vim/autoload
        curl -fLo "$plug_manager" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ||
            git clone --depth=1 https://github.com/junegunn/vim-plug ~/.vim/vim-plug && ln -sf ~/.vim/vim-plug/plug.vim "$plug_manager"
    fi
    if ! hash node &>/dev/null; then
        info "install node(coc.nvim need it)..."
        mkdir -p ~/.local
        curl -fsSL https://install-node.now.sh/latest | bash -s -- --prefix="$HOME/.local" -y
    fi
    info "install vim plugins..."
    nvim +PlugInstall +UpdateRemotePlugins +qall
}

info "install neovim..."
install_neovim

info "install python support..."
install_python_support

info "install ruby support..."
[ "$DEV_RUBY" ] && install_ruby_support

info "install node support..."
[ "$DEV_NODE" ] && install_node_support

info "install configs..."
install_configs

info "install plugins..."
install_plugins
