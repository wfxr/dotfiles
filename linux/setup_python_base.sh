#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-02-20 11:25                                                  #
################################################################################
IFS=$'\n\t'

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if ! hash pyenv &>/dev/null; then
    curl https://pyenv.run | bash || exit 1
fi
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYTHON_CONFIGURE_OPTS="--enable-shared"

# python
v=3.7.0
if ! pyenv versions | grep $v &>/dev/null; then
    pkg=Python-$v.tar.xz
    mkdir -p ~/.pyenv/cache
    if [[ ! -f ~/.pyenv/cache/$pkg ]]; then
        wget http://mirrors.sohu.com/python/$v/$pkg -P /tmp && mv /tmp/$pkg ~/.pyenv/cache/
    fi
    pyenv install $v
fi
pyenv global $v

# pypi
mkdir -p "$HOME/.pip"
cat > "$HOME/.pip/pip.conf" <<-'EOF'
[global]
index-url = https://pypi.mirrors.ustc.edu.cn/simple/
[install]
trusted-host=pypi.mirrors.ustc.edu.cn
EOF
pip install --upgrade pip

# tools
pip install pydf         # pydf is much easier to read
#pip install thefuck      # Thefuck is a magnificent app which corrects your previous console command
pip install csvkit       # A suite of utilities for converting to and working with CSV, the king of tabular file formats.
pip install jsbeautifier # json formater
pip install pygments     # tags engine
