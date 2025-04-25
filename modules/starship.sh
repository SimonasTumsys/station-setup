#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed starship
elif [[ "$os" == "macos" ]]; then
  brew install starship
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target "starship.toml" "$HOME/.config"

stow_from_dotfiles starship

echo "✅ Starhip installed."

