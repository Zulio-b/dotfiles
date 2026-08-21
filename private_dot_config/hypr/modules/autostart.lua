-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
    -- System & Environment
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Services & Applets
    hl.exec_cmd("nm-applet") -- Wi-Fi graphical applet
    hl.exec_cmd("udiskie") -- Manages removable disks (auto-mount)
    hl.exec_cmd("dunst") -- Notification daemon

    -- Theme & Visuals
    hl.exec_cmd("~/.config/hypr/scripts/theme-gtk.sh") -- Apply GTK and cursor themes
    hl.exec_cmd("awww-daemon") -- Wallpaper daemon (formerly swww)
    hl.exec_cmd("waybar") -- Status bar
    hl.exec_cmd("hyprsunset") -- Blue light filter / gamma adjustment

    -- Session Utilities
    hl.exec_cmd("cliphist wipe") -- Clipboard manager (Text)
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Clipboard manager (Text)
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Clipboard manager (Images)
    hl.exec_cmd("~/.config/hypr/scripts/battery-notify.sh")
    hl.exec_cmd("hypridle") -- Idle management daemon
    hl.exec_cmd("hyprmoncfgd --monitors-conf ~/.config/hypr/modules/monitors.lua") -- Monitor management daemon

end)
