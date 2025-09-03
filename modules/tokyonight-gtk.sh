#!/usr/bin/env bash

mkdir -p ~/.local/src

# Clone (or update if it already exists)
if [ -d ~/.local/src/Tokyonight-GTK-Theme ]; then
  git -C ~/.local/src/Tokyonight-GTK-Theme pull
else
  git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git ~/.local/src/Tokyonight-GTK-Theme
fi

# Run the installer directly
~/.local/src/Tokyonight-GTK-Theme/themes/install.sh -c dark -l

stow_from_dotfiles gtk
