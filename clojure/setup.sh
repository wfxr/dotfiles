#!/bin/bash

if [[ ! -a ~/bin/lein ]]; then
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein
    chmod +x ~/bin/lein
fi
lein
