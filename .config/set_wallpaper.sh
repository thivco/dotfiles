#!/usr/bin/env bash

dotfilespath="/home/thib/workshop/lab/dotfiles"
cd $dotfilespath/wallpaper/ || exit

newfilename=$(find . -type f | shuf -n 1 | sed 's|^\./||')

echo -e "preload = $dotfilespath/wallpaper/$newfilename\nwallpaper = ,$dotfilespath/wallpaper/$newfilename" > $dotfilespath/hypr/hyprpaper.conf

hyprctl hyprpaper preload "$dotfilespath/wallpaper/$newfilename"
hyprctl hyprpaper wallpaper ",$dotfilespath/wallpaper/$newfilename"

wal -i ~/workshop/lab/dotfiles/wallpaper/$newfilename -q