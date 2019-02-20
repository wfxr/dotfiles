#!/usr/bin/env bash
################################################################################
#    Author: Wenxuan Zhang                                                     #
#     Email: wenxuangm@gmail.com                                               #
#   Created: 2019-02-20 11:25                                                  #
################################################################################

# pyenv
curl https://pyenv.run | bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYTHON_CONFIGURE_OPTS="--enable-shared"
v=3.7.0 && wget http://mirrors.sohu.com/python/$v/Python-$v.tar.xz -P ~/.pyenv/cache/ && pyenv install $v

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
