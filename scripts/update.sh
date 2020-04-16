#!/usr/bin/env bash

echo "This script runs updates on all of my different package managers"

# Requires sudo access
yay -Syu

# Requires rustup to be installed
rustup update

# Requires neovim to be installed
nvim -c "PlugUpdate | PlugUpgrade | qa!"
