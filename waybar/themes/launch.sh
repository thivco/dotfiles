#!/bin/sh

echo "Launching Waybar. Check the launch.sh file to change the style and content of the bar."

# Kills the previous bar
killall waybarkillall waybar

# Launch the custom bar with custom source and config
waybar -c ~/.config/waybar/config & -s ~/.config/waybar/style.css