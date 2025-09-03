#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed neovim
elif [[ "$OS" == "macos" ]]; then
  brew install neovim
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf install neovim
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target "nvim" "$HOME/.config"

stow_from_dotfiles nvim

echo "✅ Neovim installed."

