#!/usr/bin/env bash

PLAYER="spotify"
FORMAT="{{ title }} - {{ artist }}"

# lấy status spotify
STATUS=$(playerctl --player=$PLAYER status 2>/dev/null || true)

MAX=70

truncate() {
  local text="$1"
  if [ ${#text} -gt $MAX ]; then
    echo "${text:0:$MAX}..."
  else
    echo "$text"
  fi
}

if [ "$STATUS" = "Playing" ]; then
    playerctl --player=$PLAYER metadata --format " $FORMAT"
elif [ "$STATUS" = "Paused" ]; then
    playerctl --player=$PLAYER metadata --format " $FORMAT"
else
  # lấy window đang focus (đắt CPU) -> chỉ chạy khi không phát Spotify
  FOCUS_TITLE=$(swaymsg -t get_tree 2>/dev/null | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused == true) | .name' | head -n1)
    truncate "$FOCUS_TITLE"
fi
