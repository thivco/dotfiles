#!/usr/bin/env bash

echo "Salut mec, on relance encore son installe ? Ah, pas serieux ca..."

# Check if the computer is using Arch
# TODO : Might be better to get the distro as a parameter and make ethe installation accordingly
if [ -f "/etc/arch-release" ]; then
    echo "Installing the apps"
    sudo pacman -S spotify

    echo "Installing the code stuff"
    sudo pacman -S npm bun
fi

# Config files
# Starting with hyprland itself

# Creating the main working directory, stuffing all of it in there to avoid clutter

if [ ! -f workshop ]; then
    echo "Setting the workshop"
    mkdir -p ~/workshop/lab ~/workshop/epitech
fi

echo "Moving the dotfiles"
mv ../dotfiles ~/workshop/lab/dotfiles

echo "Cleaning up"
rm -rf ~/dotfiles

# cp ./hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
echo "Linking the hyprland.conf file"
rm ~/.config/hypr/hyprland.conf && ln -s ~/workshop/lab/dotfiles/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf

echo "Linking bashrc"
rm ~/.bashrc && ln -s ~/workshop/lab/dotfiles/.bashrc ~/.bashrc 
source ~/.bashrc

# If we're using NixOS, add the config file to /etc/nixos
if [ -f /etc/crontab ]; then
    echo "Adding the custom config to nixOS directory"
    sudo rm -rf ~/etc/nixos/configuration.nix && mv ~/workshop/lab/dotfiles/nixos/ /etc/nixos/configuration.nix
    echo "Rebuild immediatly ?"
    read rebuild_immediatly_bool
    if [ "$rebuild_immediatly_bool" = "Y" -o "$rebuild_immediatly_bool" = "y" ]; then
        echo "Rebuilding the nixOS config"
        sudo nixos-rebuild switch
    fi
    echo "nixOS config done"
fi