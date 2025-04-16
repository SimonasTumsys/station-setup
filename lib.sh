#!/bin/bash

install_package() {
    local pkg="$1"
    local os="$2"
    local cask_flag="$3"

    if [[ "$os" == "arch" ]]; then
        sudo pacman -S --noconfirm --needed "$pkg"
    elif [[ "$os" == "macos" ]]; then
        if [[ "$cask_flag" == "--cask" ]]; then
            brew install --cask "$pkg"
        else
            brew install "$pkg"
        fi
    else
        echo "Unsupported OS: $os"
        exit 1
    fi
}

install_aur_package() {
    local pkg="$1"
    local os="$2"

    if [[ "$os" != "arch" ]]; then
        echo "❌ AUR packages only supported on Arch."
        return
    fi

    if ! command -v yay &> /dev/null; then
        echo "⚠️ 'yay' not found. Installing yay..."

        sudo pacman -S --noconfirm --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        pushd /tmp/yay
        makepkg -si --noconfirm
        popd
    fi

    yay -S --noconfirm "$pkg"
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
    local timestamp
    local backup_dir="$HOME/dotfiles-backup"

    echo "🧹 Backing up and removing existing dotfiles for $target..."

    # Create the backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    target_path="$HOME/.config/$target"  # Target path in $HOME/.config

    # Check if the file or directory exists in $HOME/.config
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        echo "📦 Moving $target_path to $backup_dir/$target"

        # Create the corresponding directory in the backup path
        mkdir -p "$backup_dir/$target"  

        # Move the target file or directory to the backup
        mv "$target_path" "$backup_dir/$target"  
    fi
}
