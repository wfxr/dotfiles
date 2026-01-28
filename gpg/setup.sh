#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-04-22 15:23                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR"

mkdir -p ~/.gnupg
chmod 700 ~/.gnupg

ln -sf "$SDIR/dirmngr.conf" ~/.gnupg/
pkill dirmngr || true # restart to reload dirmngr.conf

# import public key
# gpg --recv-keys CCAF35548C65530F

# import public key from keyserver: keys.gnupg.net
# gpg --keyserver keys.gnupg.net --recv-keys CCAF35548C65530F

gpg --allow-secret-key-import --import ./secring.gpg
gpg --allow-secret-key-import --import ./git-signing.gpg
