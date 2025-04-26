#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed picom
elif [[ "$os" == "macos" ]]; then
  echo "Picom will not install on MacOS at this time"
else
  echo "Unsupported OS: $os"
  exit 1
fi

if [[ "$OS" == "arch" ]]; then
  clean_config_target "picom.conf" "$HOME/.config"

  stow_from_dotfiles picom

  echo "✅ Picom installed."
fi
