#!/bin/bash

check_audio_active() {
    # -a checks ALL mpris players, not just the "default" one
    if playerctl -a status 2>/dev/null | grep -qi "playing"; then
        return 0
    fi
    if pactl list sinks 2>/dev/null | grep -qi "State: RUNNING"; then
        return 0
    fi
    return 1
}

silent_count=0

while true; do
    if check_audio_active; then
        silent_count=0
        echo "Music playing. Silent count = $silent_count"
    else
        silent_count=$((silent_count + 1))
        echo "Silent count = $silent_count"
        # require 2 consecutive silent checks (60s) before suspending
        if [ "$silent_count" -ge 2 ]; then
            ~/.config/hypr/scripts/lock.sh &
            sleep 0.5
            systemctl suspend
            exit 0
        fi
    fi
    sleep 30
done