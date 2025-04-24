#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed zsh
elif [[ "$os" == "macos" ]]; then
  brew install zsh
else
  echo "Unsupported OS: $os"
  exit 1
fi

chsh -s "$(which zsh)"

cd "$HOME/dotfiles"
stow zshrc

echo "✅ Zsh installed."
echo "Remember to source the stowed .zsh.global file at the start of $HOME/.zshrc"

