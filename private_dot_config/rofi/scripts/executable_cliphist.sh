#!/usr/bin/env bash
#  ┏┓┓ ┳┏┓┓┏┳┏┓┏┳┓
#  ┃ ┃ ┃┃┃┣┫┃┗┓ ┃ 
#  ┗┛┗┛┻┣┛┛┗┻┗┛ ┻ 
#                 

## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

# Actions:
# CTRL Del to delete an entry
# ALT  Del to wipe clipboard contents

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofiv
fi

while true; do
    result=$(
        rofi -i -dmenu \
            -kb-custom-1 "Control-Delete" \
            -kb-custom-2 "ALT-Delete" \
            -config ~/.config/rofi/applets/cliphist.rasi < <(cliphist list)
    )

    case "$?" inv
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    continue
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done
