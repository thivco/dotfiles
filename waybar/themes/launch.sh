#!/usr/bin/env bash
echo "Launching Waybar. Check the launch.sh file to change the style and content of the bar."

# Kills the previous bar
killall waybar
pkill waybar

# Launch the custom bar with custom source and config
waybar -c ~/.config/waybar/themes/config & -s ~/.config/waybar/themes/style.css
