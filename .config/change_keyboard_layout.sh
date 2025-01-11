#!/usr/bin/env bash

HYPRLAND_CONFIG="$HOME/workshop/lab/dotfiles/hypr/hyprland.conf"
DVORAK="us dvorak"
AZERTY="fr"

get_current_layout() {
  grep "kb_layout" "$HYPRLAND_CONFIG" | awk '{print $3}'
}

set_layout() {
  local layout=$1
  WORD_COUNT=$(echo "$layout" | wc -w)
  LAYOUT=$(echo "$layout" | awk '{print $1}')
  
  if [ "$WORD_COUNT" -gt 1 ]; then
    VARIANT=$(echo "$layout" | awk '{print $2}')
    sed -i "s/kb_layout = .*/kb_layout = $LAYOUT/" "$HYPRLAND_CONFIG"
    if grep -q "kb_variant" "$HYPRLAND_CONFIG"; then
      sed -i "s/kb_variant = .*/kb_variant = $VARIANT/" "$HYPRLAND_CONFIG"
    else
      sed -i "/kb_layout = $LAYOUT/a kb_variant = $VARIANT" "$HYPRLAND_CONFIG"
    fi
  else
    sed -i "s/kb_layout = .*/kb_layout = $LAYOUT/" "$HYPRLAND_CONFIG"
    sed -i "/kb_variant/d" "$HYPRLAND_CONFIG"
  fi
}
# Main toggle logic
current_layout=$(get_current_layout)

if [ "$current_layout" == "us" ]; then
  echo "Switching to AZERTY..."
  set_layout "$AZERTY"
else
  echo "Switching to Dvorak..."
  set_layout "$DVORAK"
fi

