#!/usr/bin/env bash
#
# matugen-pick-color.sh
#
# Extracts dominant source color candidates from the active wallpaper,
# displays them with colored Pango glyphs in a Rofi menu, and applies
# the selected color scheme via matugen.

set -euo pipefail

ROFI_THEME="${HOME}/.config/rofi/launchers/type-1/style-3.rasi"

notify_err() {
    if command -v rofi >/dev/null 2>&1; then
        rofi -e "$1"
    else
        echo "$1" >&2
    fi
}

# 1. Retrieve the currently active wallpaper
WALLPAPER="$(awww query | grep -oP 'image: \K.*' | head -n1 || true)"

if [[ -z "${WALLPAPER:-}" || ! -f "$WALLPAPER" ]]; then
    notify_err "Could not find an active wallpaper file."
    exit 1
fi

WALLPAPER_NAME="$(basename "$WALLPAPER")"

# 2. Extract unique candidate source colors from matugen
COLORS="$(matugen image "$WALLPAPER" --show-source-colors -q \
    | sed -r 's/\x1b\[[0-9;]*[a-zA-Z]//g' \
    | grep -oE '#[0-9a-fA-F]{6}' \
    | awk '!seen[$0]++')"

if [[ -z "$COLORS" ]]; then
    notify_err "Matugen could not extract any source colors."
    exit 1
fi

# 3. Format candidates for Rofi using Pango markup (colored swatch + hex)
ROFI_INPUT=""
while IFS= read -r hex; do
    ROFI_INPUT+="<span foreground=\"$hex\" font=\"18\">■</span>   $hex\n"
done <<< "$COLORS"

# 4. Display the color picker in Rofi
ROFI_ARGS=(
    -dmenu
    -markup-rows
    -i
    -p "Palette"
    -mesg "Image: $WALLPAPER_NAME"
    -no-custom
)

if [[ -f "$ROFI_THEME" ]]; then
    ROFI_ARGS+=(-theme "$ROFI_THEME")
fi

CHOICE="$(printf '%b' "$ROFI_INPUT" | rofi "${ROFI_ARGS[@]}")"

[[ -z "$CHOICE" ]] && exit 0

# 5. Sanitize selection to an exact 6-character hex string
CLEAN_HEX="$(echo "$CHOICE" | grep -oE '[0-9a-fA-F]{6}' | head -n1)"

if [[ -z "$CLEAN_HEX" ]]; then
    notify_err "Invalid hex color received: $CHOICE"
    exit 1
fi

# 6. Apply theme (with fallback for versions expecting '#')
if ! matugen color hex "$CLEAN_HEX" 2>/dev/null; then
    matugen color hex "#$CLEAN_HEX"
fi