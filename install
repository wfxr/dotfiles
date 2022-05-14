#!/usr/bin/env bash

# get dir of the current script and cd in it
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1

# show usage
usage() { echo "Usage: $(basename "$0") <module> [module]..." >&2; }

# simple log printer
loginfo() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$@" >&2; }
logerro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$@" >&2; }

[[ "$#" -lt 1 ]] && usage && exit 1

# install a module
install_module() {
    local module="$1"
    loginfo "install $module config ..."
    [[ ! -f "$module/setup.sh" ]] && logerro "$module config not found!" && return 2
    "$module/setup.sh"            && loginfo "$module config installed successfully!"
}

# install every specified modules
for module in "$@"; do
    install_module "${module%/}"
done
