#!/usr/bin/env bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || exit 1

[[ ! -a ~/bin/lein ]] &&
    wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein &&
    chmod +x ~/bin/lein && lein

[[ ! -a ~/bin/drip ]] &&
    curl -L https://raw.githubusercontent.com/ninjudd/drip/master/bin/drip > ~/bin/drip &&
    chmod +x ~/bin/drip && drip

mkdir -p ~/.lein
ln -sf "$SCRIPT_DIR/profiles.clj" ~/.lein/profiles.clj
ln -sf "$SCRIPT_DIR/profiles.clj" ~/.lein/profiles.clj
ln -sf "$SCRIPT_DIR/repl-port"    ~/.lein/repl-port

# Systemd service
[[ -f ~/.config/systemd/user/lein-repl.service ]] && exit 0
mkdir -p ~/.config/systemd/user
ln -sf "$SCRIPT_DIR/lein-repl.service" ~/.config/systemd/user/lein-repl.service
systemctl --user daemon-reload
systemctl --user enable lein-repl
systemctl --user start  lein-repl
