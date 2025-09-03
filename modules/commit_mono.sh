#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  yay -S --noconfirm otf-commit-mono-nerd
elif [[ "$OS" == "macos" ]]; then
  brew install --cask font-commit-mono-nerd-font
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf copr enable aquacash5/nerd-fonts
  sudo dnf install fira-code-nerd-fonts
else
  echo "Unsupported OS: $os"
  exit 1
fi

echo "✅ CommitMono Nerd Font installed."

