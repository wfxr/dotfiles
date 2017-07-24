#!/usr/bin/env bash

curl -s https://api.github.com/repos/ogham/exa/releases/latest \
    | grep browser_download_url \
    | grep linux \
    | cut -d'"' -f4 \
    | xargs wget -O target.zip
unzip target.zip -d ~/bin/
