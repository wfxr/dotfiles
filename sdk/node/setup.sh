#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2020-01-07 14:00                                                  #
################################################################################
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

export PATH="$HOME/.nodenv/shims:$HOME/.nodenv/bin:$PATH"

install_nodenv() {
    if ! hash nodenv &>/dev/null; then
        git clone --depth=1 https://github.com/nodenv/nodenv.git ~/.nodenv || return 1
        # node-build plugin
        mkdir -p "$(nodenv root)/plugins"
        git clone --depth=1 https://github.com/nodenv/node-build.git \
            "$(nodenv root)/plugins/node-build"

        # automatically install npm packages every time you install a new version of Node
        git clone --depth=1 https://github.com/nodenv/nodenv-default-packages.git \
            "$(nodenv root)/plugins/nodenv-default-packages"
    else
        cd ~/.nodenv || return 1
        git pull origin master
        cd "$(nodenv root)/plugins/node-build" || return 1
        git pull origin master
        cd "$(nodenv root)/plugins/nodenv-default-packages" || return 1
        git pull origin master
    fi
    # optional: compile dynamic bash extension to speed up nodenv
    cd ~/.nodenv && src/configure && make -C src
    source <(nodenv init -)
}

install_node() {
    v=18.0.0
    nodenv versions | grep $v || nodenv install $v
    nodenv global $v
    npm install -g yarn
}

loginfo "install nodenv..."
install_nodenv || exit $?

loginfo "install node..."
install_node || exit $?

grep 'DEV_NODE' ~/.zsh_local &>/dev/null || echo 'export DEV_NODE=true' >> ~/.zsh_local
