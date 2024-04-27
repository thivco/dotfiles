#!/usr/bin/env bash

echo "Salut mec, on relance encore son installe ? Ah, pas serieux ca..."

# Install essential tools

sudo pacman -S spotify

# Install javascript related tools

sudo pacman -S npm bun

# Config files
# Starting with hyprland itself

cp ./hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
# ln -s ./hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
# Commented symlink as am not too sure if it works