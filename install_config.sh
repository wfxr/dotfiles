#!/usr/bin/env bash

COLOR_NC='\e[0m' # No Color
COLOR_WHITE='\e[1;37m'
COLOR_BLACK='\e[0;30m'
COLOR_BLUE='\e[0;34m'
COLOR_LIGHT_BLUE='\e[1;34m'
COLOR_GREEN='\e[0;32m'
COLOR_LIGHT_GREEN='\e[1;32m'
COLOR_CYAN='\e[0;36m'
COLOR_LIGHT_CYAN='\e[1;36m'
COLOR_RED='\e[0;31m'
COLOR_LIGHT_RED='\e[1;31m'
COLOR_PURPLE='\e[0;35m'
COLOR_LIGHT_PURPLE='\e[1;35m'
COLOR_BROWN='\e[0;33m'
COLOR_YELLOW='\e[1;33m'
COLOR_GRAY='\e[0;30m'
COLOR_LIGHT_GRAY='\e[0;37m'

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/bin
mkdir -p ~/.config

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function restore_module() {
    module=${1%/}
    printf "${COLOR_LIGHT_BLUE}Restore $module config ...${COLOR_NC}\n"
    if [[ ! -a $module/setup.sh ]]; then
        printf "${COLOR_LIGHT_RED}$module config not found!${COLOR_NC}\n"
        return
    fi

    cd $module
    ./setup.sh
    if [[ $? = 0 ]]; then
        printf "${COLOR_LIGHT_GREEN}$module config restored successfully!${COLOR_NC}\n"
    fi
    cd ..
}

modules=$@
if [[ $# = 0 ]]; then
    for sub_dir in */; do
        if [[ -a ${sub_dir}setup.sh ]]; then
            modules+=(${sub_dir})
        fi
    done
fi


for module in ${modules[@]}; do
    restore_module $module
done
