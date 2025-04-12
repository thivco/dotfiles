#!/usr/bin/env bash


dotfilespath="/home/thib/workshop/lab/dotfiles"
dir="${dotfilespath}/wallpaper"
BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"

# Name of the program to check
PROGRAM="swww-daemon"
trans_type="outer"

# Check if the program is running
echo $BG
if pgrep "$PROGRAM" >/dev/null; then
  swww img "$BG" --transition-step 8 --transition-angle 50 --transition-pos 0.999,0.99 --transition-fps 100 --transition-type $trans_type --transition-duration 1
else
  notify-send "swww daemon not running, trying to initialize" && swww-daemon && swww img "$BG" --transition-fps 100 --transition-type $trans_type --transition-duration 1
fi

wal -i ${BG}

#cd $dotfilespath/wallpaper/ || exit
#
#newfilename=$(find . -type f | shuf -n 1 | sed 's|^\./||')
#
#echo -e "preload = $dotfilespath/wallpaper/$newfilename\nwallpaper = ,$dotfilespath/wallpaper/$newfilename" > $dotfilespath/hypr/hyprpaper.conf
#
#hyprctl hyprpaper preload "$dotfilespath/wallpaper/$newfilename"
#hyprctl hyprpaper wallpaper ",$dotfilespath/wallpaper/$newfilename"

