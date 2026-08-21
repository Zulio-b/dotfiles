#!/bin/bash

# lock.sh - Picks the right hyprlock config depending on whether
# music is currently playing, then launches hyprlock with it.

CONF_DIR="$HOME/.config/hypr/hyprlock"
CONF_WITH_PLAYER="$CONF_DIR/hyprlock-player.conf"
CONF_NO_PLAYER="$CONF_DIR/hyprlock-noplayer.conf"

# Check playback status across any MPRIS player
status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    hyprlock -c "$CONF_WITH_PLAYER"
else
    hyprlock -c "$CONF_NO_PLAYER"
fi
