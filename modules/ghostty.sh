#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed ghostty
elif [[ "$os" == "macos" ]]; then
  brew install --cask ghostty 
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target "ghostty" "$HOME/.config"

cd "$HOME/dotfiles"
stow ghostty 

echo "✅ Ghostty installed."

