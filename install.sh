#!/bin/bash

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="alias_manager"

# Download the script
echo "Downloading alias_manager..."
curl -sSLo "$SCRIPT_NAME" "https://raw.githubusercontent.com/A-Temur/EasyAliasManager/refs/heads/main/alias_manager.sh"

# Make it executable
chmod +x "$SCRIPT_NAME"

# Move it to the system directory
sudo mv "$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"

# Ensure alias file is sourced in .bashrc
if ! grep -q "source ~/.aliases" ~/.bashrc; then
    echo "source ~/.aliases" >> ~/.bashrc
fi

echo "Installation complete! Run 'alias_manager' to manage your aliases."
