#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/waybar/themes"
WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"
rofi_config="$HOME/.config/rofi/launchers/type-1/style-3.rasi"

apply_theme() {
    ln -sf "$THEMES_DIR/$1/config.jsonc" "$WAYBAR_CONFIG"
    ln -sf "$THEMES_DIR/$1/style.css"    "$WAYBAR_STYLE"
    killall waybar && waybar &disown
}

main() {
    # Find current symlink targets
    current_config=$(readlink -f "$WAYBAR_CONFIG")
    current_name=$(basename "$(dirname "$current_config")")

    # Build list of themes
    mapfile -t options < <(find "$THEMES_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort)

    # Mark active theme
    default_row=0
    MARKER="👉"
    for i in "${!options[@]}"; do
        if [[ "${options[i]}" == "$current_name" ]]; then
            options[i]="$MARKER ${options[i]}"
            default_row=$i
            break
        fi
    done

    choice=$(printf '%s\n' "${options[@]}" \
        | rofi -i -dmenu \
               -p "Waybar Theme" \
               -config "$rofi_config" \
               -selected-row "$default_row")

    [[ -z "$choice" ]] && exit 0

    choice=${choice#"$MARKER "}
    apply_theme "$choice"
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main
