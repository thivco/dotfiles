#!/usr/bin/env bash


dotfilespath="/home/thib/workshop/lab/dotfiles"
dir="${dotfilespath}/wallpaper"
BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"

PROGRAM="swww-daemon"
trans_type="outer"

echo $BG
if pgrep "$PROGRAM" >/dev/null; then
  notify-send "New wallpaper : ${BG}" 
  swww img "$BG" --transition-step 8 --transition-angle 50 --transition-pos 0.999,0.99 --transition-fps 100 --transition-type $trans_type --transition-duration 1
else
  notify-send "swww daemon not running, trying to initialize" && swww-daemon && swww img "$BG" --transition-fps 100 --transition-type $trans_type --transition-duration 1
fi

wal -i ${BG}
