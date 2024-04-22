#!/bin/sh

# Kills the previous bar
killall waybarkillall waybar

# Launch the custom bar with custom source and config
waybar -c ~/.config/waybar/config & -s ~/.config/waybar/style.css