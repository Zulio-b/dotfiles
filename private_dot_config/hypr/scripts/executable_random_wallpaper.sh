#!/usr/bin/env bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# Get the path of the current wallpaper from the first active display.
# The `awk '{print $NF}'` part extracts the last piece of the line, which is the file path.
CURRENT_WALL_PATH=$(awww query | head -n 1 | awk '{print $NF}')

# Get just the filename of the current wallpaper
CURRENT_WALL_NAME=$(basename "$CURRENT_WALL_PATH")

# Find a new, random wallpaper that is not the current one.
# If no wallpaper is set, or if the find command fails to find a *different* one
# (e.g., only one image in the folder), it will fall back to picking any random image.
NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_WALL_NAME" | shuf -n 1)

if [[ ! -f "$NEW_WALLPAPER" ]]; then
    NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
fi

# Set the new wallpaper if a file was found
if [[ -f "$NEW_WALLPAPER" ]]; then
    # swww img command to set the wallpaper
    # You can customize the transition effects
    awww img "$NEW_WALLPAPER" \
        --transition-type "any" \
        --transition-duration 1.5 \
        --transition-fps 60

    # --- AJOUT POUR MATUGEN ---
    # Génère le nouveau schéma de couleurs basé sur le fond d'écran
    # NOTE: Adaptez cette commande avec vos options matugen (ex: --mode dark, --template ...)
    echo "Génération du schéma de couleurs avec Matugen..."
    matugen image "$NEW_WALLPAPER" --mode dark --source-color-index 0    # --- (OPTIONNEL) Recharger les composants ---
    # Puisque vous configurez Hyprland, vous voudrez probablement recharger 
    # les composants qui utilisent les couleurs générées (ex: Waybar, Kitty, Hyprland lui-même).
    # Décommentez et adaptez les lignes suivantes si nécessaire :
    
    # killall -SIGUSR2 waybar  # Recharge Waybar
    # hyprctl reload          # Recharge la config Hyprland (si vos couleurs y sont)

else
    echo "No wallpapers were found in $WALLPAPER_DIR"
    exit 1
fi
