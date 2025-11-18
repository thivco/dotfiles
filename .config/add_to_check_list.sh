#!/usr/bin/env bash

NEW_NOTE_CONTENT=$(rofi -dmenu -p "Add a new entry to the list of things to do")
NOTES_LOCATION="$HOME/sync/notes/notes/The list of things to note.md"

echo "Test with concat : writing ${NEW_NOTE_CONTENT} to ${NOTES_LOCATION}"

echo -e "- [ ] ${NEW_NOTE_CONTENT}" >> "${NOTES_LOCATION}"
