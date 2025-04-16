#!/bin/bash
set -e

# possible installations
modules=("zsh" "neovim" "i3" "ghostty")

SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)

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

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/arch-release ]; then
            echo "arch"
        else
            echo "linux"  # fallback for other distros
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}


if [ "$#" -eq 0 ]; then
    echo "Usage: $0 [--all | module1,module2,...]"
    echo "Available modules: ${modules[*]}"
    exit 1
fi

# Detect OS and exit early if it is non-arch or unknown
OS=$(detect_os)
echo "🖥 Detected OS: $OS"

if [[ "$OS" == "linux" || "$OS" == "unknown" ]]; then
    echo "❌ This script currently does not support Linux or unknown OS types."
    exit 1
fi

chmod +x modules/*.sh

# Handle --all flag
if [[ "$1" == "--all" ]]; then
    echo "Installing all modules: ${modules[*]}"
    for module in "${modules[@]}"; do
        install_module "$module" "$OS"
    done
else
    # Parse the provided modules, split by commas
    IFS=',' read -r -a selected_modules <<< "$1"

    # Install each selected module
    for module in "${selected_modules[@]}"; do
        if [[ " ${modules[*]} " =~ " $module " ]]; then
            install_module "$module" "$OS"
        else
            echo "❌ Module $module not recognized." + 
                " Available modules: ${modules[*]}"
        fi
    done
fi

echo "✅ Installation complete!"

