#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)

detect_os() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/arch-release ]; then
      echo "arch"
    elif [ -f /etc/fedora-release ]; then
      echo "fedora"
    else
      echo "linux"  # fallback for other distros
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  else
    echo "unknown"
  fi
}

install_module() {
  local module="$1"
  local os="$2"
  echo "🔧 Installing $module..."

  if [ -f "$SCRIPT_DIR/modules/$module.sh" ]; then
      bash "$SCRIPT_DIR/modules/$module.sh" "$os"
  else
      echo "❌ Module $module does not exist."
      exit 1
  fi
}

OS=$(detect_os)
echo "🖥 Detected OS: $OS"

if [[ "$OS" == "linux" || "$OS" == "unknown" ]]; then
  echo "❌ This script currently does not support non-arch or non-macos OS types."
  exit 1
fi

chmod +x modules/*.sh

sudo -v

# CommitMono Nerd Font
#install_module commit_mono "$OS"

# ghostty
#install_module ghostty "$OS"

# starship
#install_module starship "$OS"

# zsh
install_module zsh "$OS"

# neovim
install_module neovim "$OS"

# tmux
install_module tmux "$OS"

# rofi
#install_module rofi "$OS"

# picom
#install_module picom "$OS"

echo "✅ Installation complete!"
echo "🚪 Logout and log back in to fully apply changes!"

