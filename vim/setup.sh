#!/usr/bin/env bash
set -euo pipefail

SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || return 1

mkdir -p ~/.config

ln -snf "$SDIR/nvim"      ~/.config/nvim
ln -sf  "$SDIR/ideavimrc" ~/.ideavimrc

# install plugins
mgrdir=~/.local/share/nvim/site/pack/packer/start/packer.nvim
[ -d $mgrdir ] || git clone --depth 1 https://github.com/wbthomason/packer.nvim $mgrdir
nvim --headless +'autocmd User PackerComplete sleep 1000m | quitall' +'PackerSync'

# for lsp in efm gopls rust_analyzer bashls sumneko_lua; do
#     nvim --headless +"LspInstall --sync $lsp" +qall
# done
