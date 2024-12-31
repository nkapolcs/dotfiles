#!/bin/bash

# Install topgrade using cargo
cargo install topgrade

# Create configuration directory if it doesn't exist
# config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
# mkdir -p "$config_dir"
# Example configuration file
# topgrade --config-reference > ~/.config/topgrade.toml
# echo "Configuration file has been placed in: $config_dir/topgrade.toml"
