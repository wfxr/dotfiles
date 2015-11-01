#=============================================================================
#       Author: Wenxuan Zhang
#        Email: wenxuan-zhang@outlook.com
#     HomePage: wenxuan.info
#=============================================================================

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# User configuration
export PATH="/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:~/src/googletest/googletest/include

export TERM=xterm-256color

source $ZSH/oh-my-zsh.sh
source $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh

export EDITOR='vim'
export CC='clang'
export CXX='clang++'

alias rcup='rcup -v'
alias rcdn='rcdn -v'

alias shutdown='sudo shutdown -h now'
alias ai='sudo apt-get install'
alias au='sudo apt-get update'
alias xx='python ~/tools/xx-net/launcher/start.py'
alias idea='sh ~/tools/intelliJ-IDEA/bin/idea.sh'
alias clion='sh ~/tools/clion/bin/clion.sh'
alias cd..='cd ..'

alias evalclip='eval `xclip -o`'

alias -s cs=vi
alias -s java=vi
alias -s txt=vi
alias -s c=vi
alias -s cpp=vi
alias -s hpp=vi
alias -s h=vi
alias -s iml=idea

# Plugin manager
source ~/tools/zsh/plugins/antigen/antigen.zsh

# Load the oh-my-zsh's library
#antigen use oh-my-zsh

antigen bundle git
antigen bundle git-extras
antigen bundle autojump
antigen bundle cp
antigen bundle vi-mode
antigen bundle sudo
antigen bundle common-aliases
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme wfxr/zsh-themes amuse

antigen apply
