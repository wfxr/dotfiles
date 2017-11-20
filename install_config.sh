#!/usr/bin/env bash

# get the dir of the current script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$SCRIPT_DIR"

# source color code
source ./color.sh

install_module() {
    module=${1%/}
    printf "${COLOR_LIGHT_BLUE}install $module config ...${COLOR_NC}\n"
    [[ ! -a $module/setup.sh ]] && printf "${COLOR_LIGHT_RED}$module config not found!${COLOR_NC}\n" && return
    "$module"/setup.sh && printf "${COLOR_LIGHT_GREEN}$module config installed successfully!${COLOR_NC}\n"
}

modules=("$@")
if [[ $# = 0 ]]; then
    for sub_dir in */; do
        [[ -f ${sub_dir}setup.sh ]] && modules+=($sub_dir)
    done
fi

for module in "${modules[@]}"; do
    install_module "$module"
done
