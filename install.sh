#!/bin/bash

# Install script for nmcat

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NMCAT_PATH="$SCRIPT_DIR/nmcat"
FISH_COMPLETIONS_PATH="$SCRIPT_DIR/completions/nmcat.fish"

echo "Installing nmcat..."

# Make nmcat executable
chmod +x "$NMCAT_PATH"

# Create symlink in PATH
if [ -d "/usr/local/bin" ]; then
    echo "Creating symlink in /usr/local/bin..."
    sudo ln -sf "$NMCAT_PATH" /usr/local/bin/nmcat
    echo "✓ nmcat installed to /usr/local/bin/nmcat"
else
    echo "Warning: /usr/local/bin doesn't exist. Please add $SCRIPT_DIR to your PATH."
fi

# Install fish completions if fish is installed
if command -v fish >/dev/null 2>&1; then
    # Find fish completions directory
    FISH_COMP_DIR=""
    
    # Check common locations
    if [ -d "$HOME/.config/fish/completions" ]; then
        FISH_COMP_DIR="$HOME/.config/fish/completions"
    elif [ -d "/usr/share/fish/completions" ]; then
        FISH_COMP_DIR="/usr/share/fish/completions"
    fi
    
    if [ -n "$FISH_COMP_DIR" ]; then
        echo "Installing fish completions..."
        if [ -w "$FISH_COMP_DIR" ]; then
            cp "$FISH_COMPLETIONS_PATH" "$FISH_COMP_DIR/"
        else
            sudo cp "$FISH_COMPLETIONS_PATH" "$FISH_COMP_DIR/"
        fi
        echo "✓ Fish completions installed to $FISH_COMP_DIR"
        echo "  Restart your fish shell or run 'source $FISH_COMP_DIR/nmcat.fish' to enable completions"
    else
        echo "Warning: Fish is installed but completions directory not found"
        echo "You can manually copy completions from: $FISH_COMPLETIONS_PATH"
    fi
else
    echo "Note: Fish shell not detected. Completions not installed."
fi

echo
echo "Installation complete!"
echo
echo "Usage: nmcat <package-name>"
echo "Example: nmcat express"
echo
echo "For help: nmcat --help"