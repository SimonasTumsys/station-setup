#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  yay -S --noconfirm otf-commit-mono-nerd
elif [[ "$os" == "macos" ]]; then
  brew install --cask font-commit-mono-nerd-font
else
  echo "Unsupported OS: $os"
  exit 1
fi

echo "✅ CommitMono Nerd Font installed."

