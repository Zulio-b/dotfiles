--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- modules/rules.lua

---------------------
---- TAGGING --------
---------------------
hl.window_rule({ name = "tag-games-steam",    match = { class = "^(steam_app_%d+)$" }, tag = "+games" })
hl.window_rule({ name = "tag-games-scope",    match = { class = "^(gamescope)$"      }, tag = "+games" })

hl.window_rule({ name = "tag-stremio",      match = { class = "^(com.stremio.stremio)$"}, tag = "+multimedia" })

hl.window_rule({ name = "tag-util-blueman",   match = { class = "^(blueman-manager)$"                          }, tag = "+utility" })
hl.window_rule({ name = "tag-util-pavuctl",   match = { class = "^(org.pulseaudio.pavucontrol)$"                           }, tag = "+utility" })
hl.window_rule({ name = "tag-util-sysmon",    match = { class = "^(org.kde.plasma-systemmonitor)$"             }, tag = "+utility" })
hl.window_rule({ name = "tag-util-portal",    match = { class = "^(org.freedesktop.impl.portal.desktop.kde)$"  }, tag = "+utility" })
hl.window_rule({ name = "tag-util-gwenview",  match = { title = "^(Save Image — Gwenview)$"                    }, tag = "+utility" })
hl.window_rule({ name = "tag-util-xdggtk",    match = { class = "^(xdg-desktop-portal-gtk)$"                   }, tag = "+utility" })
hl.window_rule({ name = "tag-util-dolphin",   match = { class = "^(org.kde.dolphin)$"                          }, tag = "+utility" })

hl.window_rule({ name = "tag-util-yazichsr",  match = { class = "^(yazi-filechooser)$"                         }, tag = "+utility" })
hl.window_rule({ name = "tag-util-yazi",      match = { class = "^(yazi)$"                                     }, tag = "+utility" })
hl.window_rule({ name = "tag-rofi-yazi",      match = { title = "^(Yazi: .*)$"                                     }, tag = "+utility" })

---------------------
---- GAME RULES -----
---------------------
hl.window_rule({
    name           = "fullscreen-multimedia",
    match          = { tag = "games"},
    idle_inhibit   = "always",
    fullscreen     = true,
    opacity        = 1.0,
    rounding       = 0,
    workspace      = "6",
})

---------------------
---- UTILITY RULES --
---------------------
hl.window_rule({
    name      = "utility-float",
    match     = { tag = "utility" },
    float     = true,
    size      = "monitor_w*0.5 monitor_h*0.5",
})

---------------------
---- APP-SPECIFIC ---
---------------------
hl.window_rule({ name = "spotify-ws",  match = { class = "^(.*Spotify.*)$" }, workspace = "5 silent" })
hl.window_rule({ name = "steam-ws",    match = { class = "^(.*steam.*)$"   }, workspace = "6 silent" })
hl.window_rule({ name = "stremio",match = { class = "^(.*com.stremio.stremio.*)$"   }, workspace = "6" , idle_inhibit   = "always",fullscreen= true, opacity = 1.0, rounding= 0})


---------------------
---- LAYER RULES ----
---------------------
hl.layer_rule({
    name      = "blur-logout",
    match     = { namespace = "logout_dialog" },
    blur      = true,
})

hl.layer_rule({
    name         = "blur-waybar",
    match        = { namespace = "waybar" },
    blur         = true,
    ignore_alpha = 0,
})

---------------------
---- DEFAULT RULES --
---------------------
hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name       = "fix-xwayland-drags",
    match      = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})