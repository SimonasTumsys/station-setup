#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed tmux
elif [[ "$os" == "macos" ]]; then
  brew install tmux
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target "$HOME/.tmux.conf"

cd "$HOME/dotfiles"
stow tmux

echo "✅ Tmux installed."

