#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2020-01-03 18:39                                                  #
################################################################################
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

install_pyenv() {
    # pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    if ! hash pyenv &>/dev/null; then
        trap 'rm -rf $TEMP' EXIT INT TERM HUP
        TEMP="$(mktemp -dt "$(basename "$0")".XXXXXX)"
        local installer="$TEMP/installer"
        local installer_url=https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer
        if ! curl -fsSL "$installer_url" >"$installer"; then
            logwarn "directly download failed. try git clone..."
            (cd "$TEMP" && git clone --depth=1 https://github.com/pyenv/pyenv-installer &&
                bash pyenv-installer/bin/pyenv-installer) || return 1
        fi

        bash "$installer" || return 1
    else
        pyenv update
    fi
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}

install_python() {
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
    # python
    v=3.11.1
    if ! pyenv versions | grep $v &>/dev/null; then
        # pkg=Python-$v.tar.xz
        # mkdir -p ~/.pyenv/cache
        # if [[ ! -f ~/.pyenv/cache/$pkg ]]; then
        #     wget http://mirrors.sohu.com/python/$v/$pkg -P /tmp && mv /tmp/$pkg ~/.pyenv/cache/ || return 1
        # fi
        # https://github.com/pyenv/pyenv/wiki/Common-build-problems
        if hash apt 2>/dev/null; then
            sudo apt update
            sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
                libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
                xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libedit-dev
        fi
        pyenv install $v || return 1
    fi
    pyenv global $v
}

install_configs() {
    mkdir -p "$HOME/.pip" || return 1
    ln -sf "$SDIR/pip.conf" "$HOME/.pip/pip.conf"
    mkdir -p ~/.config/ptpython || return 1
    ln -sf "$SDIR/ptpythonrc" ~/.config/ptpython/config.py
    ln -sf "$SDIR/style.yapf" ~/.style.yapf
    ln -sf "$SDIR/flake8"     ~/.config/flake8
    ln -sf "$SDIR/pylintrc"   ~/.config/pylintrc
}

install_tools() {
    pip install --upgrade pip
    pip install pipenv

    pip install jsbeautifier # json formater
    pip install pygments     # tags engine

    # Formatter / Repl / Linter
    pip install ptpython ipython yapf pylint
}

loginfo "install pyenv..."
install_pyenv || exit $?

loginfo "install python..."
install_python || exit $?

loginfo "install configurations..."
install_configs || exit $?

loginfo "install tools"
install_tools || exit $?
