#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2020-01-07 14:41                                                  #
################################################################################
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

loginfo()  { printf "%b[info]%b %s\n"  '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logwarn()  { printf "%b[warn]%b %s\n"  '\e[0;33m\033[1m' '\e[0m' "$@" >&2; }
logerror() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

export PATH="$HOME/.rbenv/bin:$PATH"

install_rbenv() {
    if ! hash rbenv &>/dev/null; then
        git clone --depth=1 https://github.com/rbenv/rbenv.git ~/.rbenv || return 1
        # ruby-build plugin
        mkdir -p "$(rbenv root)"/plugins
        git clone --depth=1 https://github.com/rbenv/ruby-build.git "$(rbenv root)/plugins/ruby-build"

        # automatically install gems every time you install a new version of Ruby
        git clone --depth=1 https://github.com/rbenv/rbenv-default-gems.git "$(rbenv root)/plugins/rbenv-default-gems"

        # optional: compile dynamic bash extension to speed up rbenv
        cd ~/.rbenv && src/configure && make -C src
    fi
    source <(rbenv init -)
}

install_ruby() {
    v=2.7.0
    rbenv versions | grep $v || rbenv install $v
    rbenv global $v
}

install_configs() {
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
    ln -sf "$SCRIPT_DIR"/rubocop.yml ~/.rubocop.yml
}

install_tools() {
    gem install pry
    gem install rubocop
    gem install bundler && bundle config mirror.https://rubygems.org https://gems.ruby-china.com
}

loginfo "install rbenv..."
install_rbenv || exit $?

loginfo "install ruby..."
install_ruby || exit $?

loginfo "install configs..."
install_configs || exit $?

loginfo "install tools..."
install_tools || exit $?
