#!/usr/bin/env bash

FILE_NAME=$(rofi -dmenu -p "Enter file name:")
NOTES_LOCATION="$HOME/sync/notes/notes/fleeting/"

echo "Test with concat : ${FILE_NAME}.md"

if [ -e "${NOTES_LOCATION}/${FILE_NAME}.md" ]; then
  echo "We're in the if, ${FILE_NAME}"
  COUNTER=1
  NEW_FILE_NAME="$FILE_NAME"
  while [ -e "${NOTES_LOCATION}/${NEW_FILE_NAME}.md" ]; do
    COUNTER=$((COUNTER + 1))
    NEW_FILE_NAME="${FILE_NAME%.*}_$COUNTER"
  done
  FILE_NAME="$NEW_FILE_NAME"
fi


echo "You entered: $FILE_NAME"

#the following lines work, but it's not very... config like. The kitty with a certain title is a good idea, need to add a rule in the hyprland config file
#nvim "${NOTES_LOCATION}/${FILE_NAME}.md"
kitty --title "fleeting_note" -e nvim "${NOTES_LOCATION}/${FILE_NAME}.md" &

sleep 0.5  
hyprctl dispatch focuswindow title:"fleeting_note"
hyprctl dispatch togglefloating

hyprctl dispatch movewindowpixel 500 300  # Move the window to position (500, 300)
hyprctl dispatch resizewindowpixel 1800 600  # Resize the window to 800x600 pixels
