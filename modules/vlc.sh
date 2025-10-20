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
  sudo dnf install vlc && \
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing && \
    sudo dnf update @multimedia \
      --setopt="install_weak_deps=False" \
      --exclude=PackageKit-gstreamer-plugin

else
  echo "Unsupported OS: $os"
  exit 1
fi

echo "✅ VLC installed."


