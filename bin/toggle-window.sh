#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-01-17 12:43                                                  #
################################################################################

usage() {
    echo "Usage: $(basename "$0") <command> <class>"                  >&2
    echo "   eg: $(basename "$0") google-chrome-stable google-chrome" >&2
    echo "       $(basename "$0") mailspring mailspring"              >&2
}

if [[ $# -ne 2 ]]; then
    usage && exit 2
fi

command="$1"
class="$2"

if ! target_wid=$(xdotool search --desktop 0 --class "$class"); then
    nohup "$command" &>/dev/null &
    exit 0
fi

if [[ "$(xdotool getactivewindow)" != "$target_wid" ]]; then
    xdotool windowactivate "$target_wid"
else
    xdotool windowminimize "$target_wid"
fi
