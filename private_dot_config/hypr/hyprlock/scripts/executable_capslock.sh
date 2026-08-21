#!/bin/bash
STATUS=$(cat /sys/class/leds/input*::capslock/brightness 2>/dev/null | head -n 1)
if [ "$STATUS" == "1" ]; then
    echo "<span> 󰪛 </span>" 
else
    echo ""
fi