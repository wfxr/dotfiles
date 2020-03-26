#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-04-22 15:23                                                  #
################################################################################
set -euo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR"

# import public key
# gpg --recv-keys CCAF35548C65530F

# import public key from keyserver: keys.gnupg.net
# gpg --keyserver keys.gnupg.net --recv-keys CCAF35548C65530F

gpg --allow-secret-key-import --import ./secring.gpg
