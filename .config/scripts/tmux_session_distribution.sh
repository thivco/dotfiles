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

if ! tmux has-session -t "$selected_name"; then
  tmux new-session -ds "$selected_name" -c "$selected"
  echo "yes session"
  tmux select-window -t "$selected_name:1"
fi

  echo "no session"
tmux switch-client -t "$selected_name"
