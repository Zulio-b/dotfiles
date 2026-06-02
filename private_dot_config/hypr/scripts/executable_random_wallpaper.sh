#!/usr/bin/env bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

CURRENT_WALL_PATH=$(awww query | head -n 1 | awk '{print $NF}')

CURRENT_WALL_NAME=$(basename "$CURRENT_WALL_PATH")

NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_WALL_NAME" | shuf -n 1)

if [[ ! -f "$NEW_WALLPAPER" ]]; then
    NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
fi

# Set the new wallpaper if a file was found
if [[ -f "$NEW_WALLPAPER" ]]; then
    awww img "$NEW_WALLPAPER" \
        --transition-type "any" \
        --transition-duration 1.5 \
        --transition-fps 60

    matugen image "$NEW_WALLPAPER" --mode dark --source-color-index 0    
else
    echo "No wallpapers were found in $WALLPAPER_DIR"
    exit 1
fi
