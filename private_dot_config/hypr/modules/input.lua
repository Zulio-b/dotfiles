---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout   = "fr,us",
        -- kb_options  = "grp:alt_shift_toggle",
        -- resolve_binds_by_sym = 1,

        numlock_by_default = true,
        follow_mouse       = 1,
        sensitivity        = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 2, direction = "pinchout", mods = "SUPER",  action = "float"})
hl.gesture({ fingers = 2, direction = "pinchin",mods = "SUPER",    action = "float", mode = "tile"})
hl.gesture({ fingers = 3, direction = "down", mods = "SUPER", action = "special", workspace_name = "magic", disable_inhibit = true })
hl.gesture({ fingers = 4, direction = "up", action = function() hl.exec_cmd("pkill rofi || ~/.config/rofi/launchers/type-1/launcher.sh -drun -terminal kitty") end })

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})