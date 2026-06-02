#!/bin/bash

battery=$(ls /sys/class/power_supply/ | grep -m1 "^BAT")
if [ -z "$battery" ]; then
    exit 0
fi

notify_sent_20=false
notify_sent_5=false

while true; do
    capacity=$(cat /sys/class/power_supply/$battery/capacity)
    status=$(cat /sys/class/power_supply/$battery/status)

    if [ "$status" != "Charging" ]; then
        if [ "$capacity" -le 5 ] && [ "$notify_sent_5" = false ]; then
            notify-send -u critical -t 0 "󰂃 Battery Critical" "${capacity}% — plug in now!"
            notify_sent_5=true
            notify_sent_20=true
        elif [ "$capacity" -le 20 ] && [ "$notify_sent_20" = false ]; then
            notify-send -u critical -t 0 "󰁻 Battery Low" "${capacity}% — consider charging"
            notify_sent_20=true
        fi
    else
        notify_sent_20=false
        notify_sent_5=false
    fi

    sleep 120
done