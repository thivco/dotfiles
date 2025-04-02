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

nvim "${NOTES_LOCATION}/${FILE_NAME}.md"
