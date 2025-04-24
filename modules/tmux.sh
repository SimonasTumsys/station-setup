#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

install_package tmux "$OS"

clean_config_target "$HOME/.tmux"

cd "$HOME/dotfiles"
stow tmux

echo "✅ Tmux installed."

