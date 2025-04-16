#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

install_package neovim "$OS"

clean_config_target nvim

cd "$HOME/dotfiles"
stow nvim

echo "✅ Neovim installed and configured."

