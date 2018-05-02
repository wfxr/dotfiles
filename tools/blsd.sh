#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan                                                           #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2018-05-02 16:30                                                  #
################################################################################

hash blsd &>/dev/null || (bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install) && mv blsd ~/bin)
