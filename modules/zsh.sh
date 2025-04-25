#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed zsh
elif [[ "$OS" == "macos" ]]; then
  brew install zsh
else
  echo "Unsupported OS: $OS"
  exit 1
fi

if [[ "$OS" == "macos" ]]; then
  echo "🔐 macOS — please update shell manually:"
  echo "    chsh -s $(which zsh)"
else
  echo "🔧 Changing shell to zsh for $USER..."
  sudo chsh -s "$(which zsh)" "$USER"
fi

clean_config_target ".zshrc" "$HOME"
clean_config_target ".zshrc.global" "$HOME"
clean_config_target ".zsh" "$HOME"

stow_from_dotfiles zshrc

# create a barebones .zshrc
echo -e '# keep this at the top\nsource "$HOME/.zshrc.global"' > "$HOME/.zshrc"

echo "✅ Zsh installed."

