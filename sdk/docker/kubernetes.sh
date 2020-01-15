#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-04-05 10:28
#===============================================================================

release="$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$(uname | tr 'A-Z' 'a-z')/amd64/kubectl"
hash kubectl &>/dev/null ||
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$release" &&
    chmod +x kubectl &&
    mkdir -p ~/bin &&
    mv kubectl ~/bin
