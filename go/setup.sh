#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2017-12-22 12:40
#===============================================================================

# Ported from https://github.com/Xuyuanp/dotfiles/blob/master/gotools.sh

base=$GOPATH/src/golang.org/x
mkdir -p "$base" && cd "$base" || exit 1

repos=(crypto net sys text tools)

for repo in "${repos[@]}"; do
    test -d "$base/$repo" || git clone --depth=1 "https://github.com/golang/$repo"
done

for repo in "${repos[@]}"; do
    cd "$base/$repo" && go install ./... && echo "$repo installed."
done
