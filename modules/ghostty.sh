#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed ghostty
elif [[ "$OS" == "macos" ]]; then
  brew install --cask ghostty 
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf copr enable scottames/ghostty
  sudo dnf install ghostty
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target "ghostty" "$HOME/.config"

stow_from_dotfiles ghostty

echo "✅ Ghostty installed."

