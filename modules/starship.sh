#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

install_package starship "$OS"

clean_config_target "$HOME/.config/starship"

cd "$HOME/dotfiles"
stow nvim

echo "✅ Starhip installed."
