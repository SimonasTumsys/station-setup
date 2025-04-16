#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

echo "🔧 Installing Zsh..."

install_package zsh "$OS"

chsh -s "$(which zsh)"

cd "$HOME/dotfiles"
stow zsh

echo "✅ Zsh installed and configured."

