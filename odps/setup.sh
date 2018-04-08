#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2017-12-16 12:18
#===============================================================================
package=odpscmd_public.zip
wget "http://repo.aliyun.com/download/odpscmd/latest/$package" -O "/tmp/$package" || exit $?
mkdir -p ~/tools/odps && cd ~/tools/odps || return 1
unzip "/tmp/$package"

ln -sf ~/tools/odps/bin/odpscmd ~/bin
