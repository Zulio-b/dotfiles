#!/bin/bash

if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

emoji=$(rofimoji --action print --selector-args "-config ~/.config/rofi/launchers/type-1/style-3.rasi")

if [ -n "$emoji" ]; then
    echo -n "$emoji" | wl-copy
    notify-send -t 2000 "Emoji Copied" "$emoji"
fi