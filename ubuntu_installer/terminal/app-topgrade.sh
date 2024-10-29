#!/bin/bash

# Change to temporary directory
cd /tmp

# Install topgrade using cargo
cargo install topgrade

# Create configuration directory if it doesn't exist
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$config_dir"

# Download example configuration file
wget "https://raw.githubusercontent.com/topgrade-rs/topgrade/main/config.example.toml" -O "$config_dir/topgrade.toml"

# Return to original directory
cd -

echo "Topgrade has been installed. You can run it by typing 'topgrade' in the terminal"
echo "Configuration file has been placed in: $config_dir/topgrade.toml"