#!/bin/bash

ICON_FILE="$HOME/.config/rofi/scripts/icons.txt"

[ ! -f "$ICON_FILE" ] && exit 1

choice=$(cat "$ICON_FILE" | rofi -dmenu -i -p "Nerd Icon" -config ~/.config/rofi/launchers/type-1/style-3.rasi)

[ -z "$choice" ] && exit

icon=$(echo "$choice" | awk '{print $1}')

echo -n "$icon" | wl-copy
notify-send -t 2000 "Icon Copied" "$icon"

