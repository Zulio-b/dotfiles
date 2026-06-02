#!/bin/bash

# Define the themes
GTK_THEME="adw-gtk3-dark"
COLOR_SCHEME="prefer-dark"
ICON_THEME="Papirus-Dark"
CURSOR_THEME="Bibata-Modern-Classic"

# Apply the themes via gsettings
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"

