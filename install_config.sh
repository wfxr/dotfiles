#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

# show usage and quit
usage() {
    echo "Usage: $0 <module> [module]..." >&2
    exit 1
}

[[ "$#" -lt 1 ]] && usage

# source color code
source scripts/color.sh

install_module() {
    local module="$1"
    echo "${COLOR_LIGHT_BLUE}install $module config ...${COLOR_NC}"
    [[ ! -f $module/setup.sh ]] && echo "${COLOR_LIGHT_RED}$module config not found!${COLOR_NC}" && return
    "$module"/setup.sh          && echo "${COLOR_LIGHT_GREEN}$module config installed successfully!${COLOR_NC}"
}

for module in "$@"; do
    install_module "${module%/}"
done
