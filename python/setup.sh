#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2020-01-03 18:39                                                  #
################################################################################
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

info()  { printf "%b[info]%b  %s\n" '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
warn()  { printf "%b[warn]%b  %s\n" '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
error() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

install_pyenv() {
    # pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    if ! hash pyenv &>/dev/null; then
        curl https://pyenv.run | bash || exit 1
    fi
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}

install_python() {
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
    # python
    v=3.8.0
    if ! pyenv versions | grep $v &>/dev/null; then
        pkg=Python-$v.tar.xz
        mkdir -p ~/.pyenv/cache
        if [[ ! -f ~/.pyenv/cache/$pkg ]]; then
            wget http://mirrors.sohu.com/python/$v/$pkg -P /tmp && mv /tmp/$pkg ~/.pyenv/cache/
        fi
        pyenv install $v
    fi
    pyenv global $v
}

install_pipenv() {
    hash pipenv &>/dev/null && return

    if hash apt 2>/dev/null; then
        sudo apt update && sudo apt install pipenv -y
    elif hash pacman 2>/dev/null; then
        sudo pacman --noconfirm -Sy python-pipenv
    elif hash brew 2>/dev/null; then
        sudo brew install pipenv
    fi
}

install_configs() {
    mkdir -p "$HOME/.pip"
    ln -sf "$SDIR/pip.conf" "$HOME/.pip/pip.conf"
    mkdir -p ~/.ptpython
    ln -sf "$SDIR/ptpythonrc" ~/.ptpython/config.py
    ln -sf "$SDIR/style.yapf" ~/.style.yapf
}

install_tools() {
    pip install --upgrade pip

    #pip install thefuck      # Thefuck is a magnificent app which corrects your previous console command
    #pip install csvkit       # A suite of utilities for converting to and working with CSV, the king of tabular file formats.
    pip install pydf         # pydf is much easier to read
    pip install jsbeautifier # json formater
    pip install pygments     # tags engine

    # Formatter / Repl / Linter
    pip install yapf ptpython pylint
}

info "install pyenv..."
install_pyenv

info "install python..."
install_python

info "install pipenv..."
install_pipenv

info "install configurations..."
install_configs

info "install tools"
install_tools
