#!/bin/bash

# lock.sh - Picks the right hyprlock config depending on whether
# music is currently playing, then launches hyprlock with it.

CONF_DIR="$HOME/.config/hypr/hyprlock"
CONF_WITH_PLAYER="$CONF_DIR/hyprlock-player.conf"
CONF_NO_PLAYER="$CONF_DIR/hyprlock-noplayer.conf"

# Check playback status across any MPRIS player
if playerctl status 2>/dev/null | grep -qE 'Playing|Paused'; then
    CONFIG="$CONF_WITH_PLAYER"
else
    CONFIG="$CONF_NO_PLAYER"
fi

hyprlock -c "$CONFIG" >> /tmp/hyprlock.log 2>&1