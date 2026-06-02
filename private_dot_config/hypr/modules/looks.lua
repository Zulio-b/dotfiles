-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Matugen implementation 
return function(c)

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 2,

        border_size = 2,

        col = {
            active_border = { colors = { c.primary, c.tertiary }, angle = 45 },
                inactive_border = c.outline,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 15,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = c.shadow,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- modules/animations.lua

-- Curves
hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1,  1.1}, {0.1, 1.1}  } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0,   1}    } })
hl.curve("liner",  { type = "bezier", points = { {1,    1},   {1,   1}    } })

-- Animations
hl.animation({ leaf = "windows",          enabled = true, speed = 6,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 6,  bezier = "winIn",   style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 5,  bezier = "winOut",  style = "slide" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 5,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "border",           enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 30, bezier = "liner",   style = "loop" })
hl.animation({ leaf = "fade",             enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,  bezier = "wind" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7,  bezier = "default", style = "slidefadevert -50%" })


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        force_split = 2
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

end
