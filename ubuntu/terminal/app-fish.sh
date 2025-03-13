#!/bin/bash

# Update package lists
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update

# Install Fish shell and dependencies
sudo apt install -y fish bat direnv fzf
cargo install lsd

# Get the path of the Fish binary
FISH_PATH=$(which fish)

# Add Fish to the list of allowed shells if not already present
# if ! grep -q "$FISH_PATH" /etc/shells; then
#     echo "$FISH_PATH" | tee -a /etc/shells
# fi

# Get the username of the user who invoked sudo
SUDO_USER=$(logname || who am i | awk '{print $1}')

# Only change shell if not already fish
if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH" "$SUDO_USER"
fi

# Install Fisher (plugin manager) if not already installed
if [ ! -f "/home/$SUDO_USER/.config/fish/functions/fisher.fish" ]; then
    sudo -u "$SUDO_USER" fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fi

# Make sure the plugins are installed
sudo -u "$SUDO_USER" fish -c 'fisher install jorgebucaran/hydro'
sudo -u "$SUDO_USER" fish -c 'fisher install patrickf1/fzf.fish'