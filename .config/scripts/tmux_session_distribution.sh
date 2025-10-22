#!/usr/bin/env bash

DIRS=(
  "$HOME/workshop"
  "$HOME/workshop/lab/"
)

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find "${DIRS[@]}" -maxdepth 1 -type d \
    |  sed "s|^$HOME/||" \
    |  fzf --margin 10% --color="bw")
  [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0


selected_name=$(basename "$selected" | tr . _)

tmux_session_check $selected_name $selected
