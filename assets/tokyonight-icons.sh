#!/bin/bash

# Tokyo Night icon pack
# Try to download by using this script. If it fails, go to:
# https://github.com/ljmill/tokyo-night-icons/releases
# and download the assets from there.

set -euo pipefail


ICON_DIR="$HOME/.local/share/icons"
ARCHIVE="TokyoNight-SE.tar.bz2"
URL="https://github.com/ljmill/tokyo-night-icons/releases/download/v0.2.0/$ARCHIVE"

mkdir -p "$ICON_DIR"

echo "Downloading Tokyo Night icons..."
curl -L -o "$ICON_DIR/$ARCHIVE" "$URL"

echo "Extracting..."
tar -xjf "$ICON_DIR/$ARCHIVE" -C "$ICON_DIR"

echo "Cleaning up..."
rm "$ICON_DIR/$ARCHIVE"

echo "Symlinking to /usr/share/icons ..."
sudo ln -s "$HOME/.local/share/icons/TokyoNight-SE" /usr/share/icons/TokyoNight-SE

echo "Done. Icons installed to $ICON_DIR"

