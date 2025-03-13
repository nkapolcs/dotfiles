#!/bin/bash

sudo apt update
sudo apt install -y libgtk-4-dev libadwaita-1-dev git

# Get the username of the user who invoked sudo
SUDO_USER=$(logname || who am i | awk '{print $1}')
INSTALL_DIR="/home/$SUDO_USER/.local"
BUILD_DIR=$(mktemp -d)
cd "$BUILD_DIR" || exit 1

echo "Cloning Ghostty repository..."
git clone https://github.com/ghostty-org/ghostty
cd ghostty || exit 1

echo "Building Ghostty..."
zig build -p "$INSTALL_DIR" -Doptimize=ReleaseFast

if [ $? -eq 0 ]; then
    echo "Ghostty has been successfully installed to $INSTALL_DIR"    
    cd ..
    rm -rf "$BUILD_DIR"
    
    echo "Installation complete!"
    echo "Note: If Ghostty fails to launch from your app launcher, ensure that $INSTALL_DIR/bin is in your system PATH"
else
    echo "Failed to build Ghostty"
    exit 1
fi