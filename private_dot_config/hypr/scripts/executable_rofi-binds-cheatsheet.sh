#!/bin/bash

# 1. Key Translation Array
declare -A K=(
    [ampersand]=1 [eacute]=2 [quotedbl]=3 [apostrophe]=4 [parenleft]=5
    [minus]=6 [egrave]=7 [underscore]=8 [ccedilla]=9 [agrave]=0
    [Return]=Enter [space]=Space [equal]== [comma]=,
    [XF86AudioRaiseVolume]=Vol+ [XF86AudioLowerVolume]=Vol-
    [XF86AudioMute]=Mute [XF86AudioMicMute]=MicMute
    [XF86AudioNext]=Next [XF86AudioPrev]=Prev
    [XF86AudioPlay]=Play [XF86AudioPause]=Pause
    [XF86MonBrightnessUp]=Bright+ [XF86MonBrightnessDown]=Bright-
    [mouse:272]=LMB [mouse:273]=RMB
    [mouse_down]=ScrollDown [mouse_up]=ScrollUp
)

# 2. Modifier Translation Array (Replaces the slow 'mod()' function)
declare -A MODS=(
    [0]="" [1]="SHIFT + " [4]="CTRL + " [5]="CTRL + SHIFT + "
    [8]="ALT + " [64]="SUPER + " [65]="SUPER + SHIFT + "
    [68]="SUPER + CTRL + " [69]="SUPER + CTRL + SHIFT + "
    [72]="SUPER + ALT + " [9]="ALT + SHIFT + "
)

# 3. Static gesture entries
GESTURES=(
    "👆 Gestures|3 fingers horizontal|Switch workspace"
    "👆 Gestures|4 fingers down|Close window"
    "👆 Gestures|3 fingers up|Toggle fullscreen"
    "👆 Gestures|2 fingers pinch out|Toggle float"
    "👆 Gestures|2 fingers pinch in|Tile window"
    "👆 Gestures|SUPER + 3 fingers down|Toggle magic scratchpad"
    "👆 Gestures|4 fingers up|Open app launcher"
)

BINDS=()

# 4. Parse binds 
while IFS='|' read -r mask key desc; do
    
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

    # 5. Categorize inline
    case "$desc" in
        *orkspace*|*cratchpad*) category="🗂 Workspaces" ;;
        *rack*|*olume*|*ute*|*right*|*lay*|*ause*) category="🎵 Media" ;;
        *erminal*|*rowser*|*ditor*|*ile*|*team*|*olor*|*auncher*) category="🖥 Programs" ;;
        *allpaper*|*aybar*|*logout*|*ock*) category="🎨 System UI" ;;
        *apture*|*creenshot*) category="📸 Screenshot" ;;
        *ocus*|*loat*|*esize*|*ove*|*split*) category="🪟 Windows" ;;
        *ofi*|*emoji*|*lipboard*|*calc*|*heatsheet*) category="🔍 Rofi" ;;
        *esture*) category="👆 Gestures" ;;
        *) category="⚙ Misc" ;;
    esac

    BINDS+=("$category|$bind_str|$desc")

done < <(hyprctl binds -j | jq -r '.[] | select(.description != "" and .description != null) | "\(.modmask)|\(.key)|\(.description)"')

{ printf '%s\n' "${GESTURES[@]}"; printf '%s\n' "${BINDS[@]}"; } | sort | awk -F'|' '
    { if ($1!=p) { if (p) print ""; print $1; p=$1 }
      printf "  %-35s %s\n", $2, $3 }
' | rofi -dmenu -i -p "Keybinds" \
    -theme ~/.config/rofi/launchers/type-1/style-3.rasi \
    -theme-str 'window{width:700px;}listview{lines:15;}' \
    -no-custom