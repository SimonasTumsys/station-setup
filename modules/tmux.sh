#!/bin/bash
set -e

OS="$1"
SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../lib.sh"

if [[ "$OS" == "arch" ]]; then
  sudo pacman -S --noconfirm --needed tmux
elif [[ "$OS" == "macos" ]]; then
  brew install tmux
elif [[ "$OS" == "fedora" ]]; then
  sudo dnf install tmux
else
  echo "Unsupported OS: $os"
  exit 1
fi

clean_config_target ".tmux.conf" "$HOME"
clean_config_target ".tmux" "$HOME"

stow_from_dotfiles tmux

# Install TPM if it's not already present
echo "📥 Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "📦 Installing tmux plugins via TPM..."
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
else
  echo "❌ TPM not found at ~/.tmux/plugins/tpm"
fi

echo "🔁 Reloading tmux config..."
if tmux info &>/dev/null; then
  tmux source-file "$HOME/.tmux.conf"
else
  echo "⚠️ tmux is not running. Skipping config reload."
fi

echo "✅ Tmux installed."

