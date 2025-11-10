#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed langpacks-lt
elif [[ "$OS" == "macos" ]]; then
  #sudo port install rofi
  echo "No need to install lang on MacOs"
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf install langpacks-lt
else
  echo "Unsupported OS: $os"
  exit 1
fi

echo "✅ Langpacks-LT installed."

