#!/usr/bin/env bash

echo "Salut mec, on relance encore son installe ? Ah, pas serieux ca..."

# Install essential tools

# sudo pacman -S spotify

# Install javascript related tools

# sudo pacman -S npm bun

# Config files
# Starting with hyprland itself

# Creating the main working directory, stuffing all of it in there to avoid clutter

echo "Setting the workshop"
mkdir -p ~/workshop/lab ~/workshop/epitech

echo "Moving the dotfiles"
mv ../dotfiles ~/workshop/lab/dotfiles

echo "Cleaning up"
rm -rf ~/dotfiles

# cp ./hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
echo "Linking the hyprland.conf file"
rm ~/.config/hypr/hyprland.conf && ln -s ~/workshop/lab/dotfiles/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf

echo "Linking bashrc"
rm ~/.bashrc && ln -s ~/workshop/lab/dotfiles/.bashrc ~/.bashrc && source ~/.bashrc
