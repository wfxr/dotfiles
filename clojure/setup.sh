#!/usr/bin/env bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

[[ ! -a ~/bin/lein ]] &&
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein &&
    chmod +x ~/bin/lein

mkdir -p ~/.lein
ln -sf "$SCRIPT_DIR/profiles.clj" ~/.lein/profiles.clj
