#!/bin/bash

ensure_yay() {
  if ! command -v yay &> /dev/null; then
    echo "⚠️ 'yay' not found. Installing yay..."

    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay || return
    makepkg -si --noconfirm
    popd || return
  fi
}

ensure_stow() {
  local os="$1"
  if ! command -v stow &> /dev/null; then
    echo "📦 Installing stow..."
    install_package stow "$os"
  fi
}

clean_config_target() {
  local target="$1"
  local target_dir="$2"
  local backup_dir="$HOME/dotfiles-backup"

  echo "🧹 Backing up and removing existing dotfiles for $target..."

  # Create the backup directory if it doesn't exist
  mkdir -p "$backup_dir"

  # Check if the file or directory exists in $HOME/.config
  if [ -e "$target_dir/$target" ] || [ -L "$target_dir/$target" ]; then
    echo "📦 Moving $target to $backup_dir/$target"

    # Create the corresponding directory in the backup path
    mkdir -p "$backup_dir/$target"

    # Move the target file or directory to the backup
    mv "$target_dir/$target" "$backup_dir/$target"
  fi
}

