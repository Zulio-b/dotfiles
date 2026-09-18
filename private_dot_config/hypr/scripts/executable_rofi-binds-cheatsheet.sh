#!/bin/bash

# 1. Key Translation Array (includes AZERTY keycodes 10-19)
declare -A K=(
    # Numbers / AZERTY row (keysyms & keycodes)
    [ampersand]=1 [eacute]=2 [quotedbl]=3 [apostrophe]=4 [parenleft]=5
    [minus]=6 [egrave]=7 [underscore]=8 [ccedilla]=9 [agrave]=0
    [code:10]=1 [code:11]=2 [code:12]=3 [code:13]=4 [code:14]=5
    [code:15]=6 [code:16]=7 [code:17]=8 [code:18]=9 [code:19]=0

    # Common keys
    [Return]=Enter [space]=Space [equal]== [comma]=, [Delete]=Del
    [Escape]=Esc [Tab]=Tab [left]=Left [right]=Right [up]=Up [down]=Down

    # Media & Hardware keys
    [XF86AudioRaiseVolume]=Vol+ [XF86AudioLowerVolume]=Vol-
    [XF86AudioMute]=Mute [XF86AudioMicMute]=MicMute
    [XF86AudioNext]=Next [XF86AudioPrev]=Prev
    [XF86AudioPlay]=Play [XF86AudioPause]=Pause
    [XF86MonBrightnessUp]=Bright+ [XF86MonBrightnessDown]=Bright-
    [XF86Launch6]=MicMute

    # Mouse
    [mouse:272]=LMB [mouse:273]=RMB
    [mouse_down]=ScrollDown [mouse_up]=ScrollUp
)

# 2. Modifier Translation Array
declare -A MODS=(
    [0]=""
    [1]="SHIFT + "
    [4]="CTRL + "
    [5]="CTRL + SHIFT + "
    [8]="ALT + "
    [9]="ALT + SHIFT + "
    [64]="SUPER + "
    [65]="SUPER + SHIFT + "
    [68]="SUPER + CTRL + "
    [69]="SUPER + SHIFT + CTRL + "
    [72]="SUPER + ALT + "
    [73]="SUPER + ALT + SHIFT + "
)

# 3. Static gesture entries
GESTURES=(
    "8. 👆 Gestures|3 fingers horizontal|Switch workspace"
    "8. 👆 Gestures|4 fingers down|Close window"
    "8. 👆 Gestures|3 fingers up|Toggle fullscreen"
    "8. 👆 Gestures|SUPER + 2 fingers pinch out|Toggle float"
    "8. 👆 Gestures|SUPER + 2 fingers pinch in|Tile window"
    "8. 👆 Gestures|SUPER + 3 fingers vertical|Toggle magic scratchpad"
    "8. 👆 Gestures|4 fingers up|Open app launcher"
)

BINDS=()

# 4. Parse Hyprland binds
while IFS='|' read -r mask key desc; do
    [[ -z "$key" ]] && continue

    # Translate modifier mask
    if [[ -n "${MODS[$mask]+isset}" ]]; then
        mod_str="${MODS[$mask]}"
    else
        mod_str="MOD($mask) + "
    fi

    # Translate key
    if [[ -n "${K[$key]}" ]]; then
        key_str="${K[$key]}"
    else
        key_str="$key"
    fi

    bind_str="${mod_str}${key_str}"
    local_desc="${desc,,}"

    # 5. Precise Categorization
    case "$local_desc" in
        # Workspaces & Scratchpad
        *workspace*|*scratchpad*)
            category="1. 🗂 Workspaces"
            ;;

        # Window navigation, management & focus
        *focus*|*window*|*float*|*split*|*fullscreen*|*tile*|*cycle*)
            category="2. 🪟 Windows"
            ;;

        # Launchers, Rofi popups & selectors
        *rofi*|*launcher*|*selector*|*picker*|*cheatsheet*|*clipboard*|*calculator*|*calc*|*emoji*|*matugen*)
            category="3. 🔍 Launchers & Tools"
            ;;

        # Standalone desktop apps (spaces must be quoted/escaped in patterns)
        *terminal*|*browser*|*editor*|*spotify*|*game*|*steam*|*"file manager"*)
            category="4. 🖥 Applications"
            ;;

        # Media, Volume, Brightness
        *volume*|*mute*|*mic*|*track*|*play*|*pause*|*brightness*)
            category="5. 🎵 Media & Brightness"
            ;;

        # Screenshots
        *screenshot*|*capture*|*grimblast*)
            category="6. 📸 Screenshots"
            ;;

        # System controls & Desktop UI
        *waybar*|*wallpaper*|*lock*|*logout*|*"exit hyprland"*|*layout*|*keyboard*)
            category="7. 🎨 System & Session"
            ;;

        # Static gestures
        *gesture*)
            category="8. 👆 Gestures"
            ;;

        *)
            category="9. ⚙ Misc"
            ;;
    esac

    BINDS+=("$category|$bind_str|$desc")

done < <(hyprctl binds -j | jq -r '.[] | select(.description != "" and .description != null) | "\(.modmask)|\(.key)|\(.description)"')

# 6. Output to Rofi (sorted by category number, stripped for display)
{ printf '%s\n' "${GESTURES[@]}"; printf '%s\n' "${BINDS[@]}"; } | sort -V | awk -F'|' '
    {
        cat = $1
        sub(/^[0-9]+\. /, "", cat)
        if (cat != p) {
            if (p) print ""
            print cat
            p = cat
        }
        printf "  %-32s %s\n", $2, $3
    }
' | rofi -dmenu -i -p "Keybinds" \
    -theme ~/.config/rofi/launchers/type-1/style-3.rasi \
    -theme-str 'window{width:700px;}listview{lines:15;}' \
    -no-custom