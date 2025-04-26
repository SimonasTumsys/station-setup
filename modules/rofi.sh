#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed rofi
elif [[ "$os" == "macos" ]]; then
  #sudo port install rofi
  echo "Rofi will not install on MacOS at this time"
else
  echo "Unsupported OS: $os"
  exit 1
fi

if [[ "$OS" == "arch" ]]; then
  clean_config_target "config.rasi" "$HOME/.config"

  stow_from_dotfiles rofi

  echo "✅ Rofi installed."
fi

