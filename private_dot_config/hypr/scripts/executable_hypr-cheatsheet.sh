#!/usr/bin/env bash
# hypr-cheatsheet.sh — Hyprland keybindings cheatsheet in rofi

ROFI_THEME="$HOME/.config/rofi/launchers/type-1/style-3.rasi"

hyprctl binds -j | python3 -c "
import json, sys

data = json.load(sys.stdin)
current_section = None

for b in data:
    desc = b.get('description', '').strip()
    key  = b.get('key', '').strip()
    sub  = b.get('submap', '') or 'General'

    if not desc or not key:
        continue

    if sub != current_section:
        if current_section is not None:
            print('')
        print(f'── {sub}')
        current_section = sub

    print(f'  {desc:<38}{key}')
" | rofi \
    -dmenu \
    -i \
    -p "  Keybinds" \
    -config "$ROFI_THEME" \
    -no-custom \
    -theme-str '
        window {
            width: 680px;
            height: 600px;
            location: center;
            anchor: center;
            x-offset: 0;
            y-offset: 0;
            fullscreen: false;
        }
        listview {
            lines: 22;
            scrollbar: true;
        }
        element-text {
            font: "JetBrainsMono Nerd Font 11";
        }
    ' \
    > /dev/null