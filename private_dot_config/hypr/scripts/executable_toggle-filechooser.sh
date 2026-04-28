#!/bin/bash

CONFIG_FILE="$HOME/.config/xdg-desktop-portal/hyprland-portals.conf"

# Check if the config currently points to Yazi
if grep -q "FileChooser=termfilechooser" "$CONFIG_FILE"; then
    # State is Yazi -> Switch to Dolphin
    systemctl --user unmask plasma-xdg-desktop-portal-kde.service
    
    cat <<EOF > "$CONFIG_FILE"
[preferred]
default=hyprland;kde;gtk
org.freedesktop.impl.portal.FileChooser=kde
EOF
    
    # Reload services
    systemctl --user daemon-reload
    systemctl --user restart xdg-desktop-portal.service 2>/dev/null
    
    # Send Notification
    notify-send -t 3000 -i system-file-manager "File Picker Changed" "Now using: Dolphin 🐬"

else
    # State is Dolphin -> Switch to Yazi
    systemctl --user stop plasma-xdg-desktop-portal-kde.service
    systemctl --user mask plasma-xdg-desktop-portal-kde.service
    
    cat <<EOF > "$CONFIG_FILE"
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.FileChooser=termfilechooser
EOF

    # Reload services
    systemctl --user daemon-reload
    systemctl --user restart xdg-desktop-portal.service xdg-desktop-portal-termfilechooser.service 2>/dev/null
    
    # Send Notification
    notify-send -t 3000 -i utilities-terminal "File Picker Changed" "Now using: Yazi 🦆"
fi

