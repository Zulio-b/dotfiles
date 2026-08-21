return function(terminal, fileManager, menu, browser, editor, game, colorPicker)

    local mainMod    = "SUPER"
    local rofi_theme = "~/.config/rofi/launchers/type-1/style-3.rasi"

    -- --- Basic Binds ---
    hl.bind(mainMod .. " + return",        hl.dsp.exec_cmd(terminal),                                 { description = "Open terminal" })
    hl.bind(mainMod .. " + Q",             hl.dsp.window.close(),                                     { description = "Close active window" })
    hl.bind(mainMod .. " + Delete",        hl.dsp.exit(),                                             { description = "Exit Hyprland" })
    hl.bind(mainMod .. " + F",             hl.dsp.exec_cmd(fileManager),                              { description = "Open file manager" })
    hl.bind(mainMod .. " + B",             hl.dsp.exec_cmd(browser),                                  { description = "Open web browser" })
    hl.bind(mainMod .. " + SHIFT + B",     hl.dsp.exec_cmd(browser .. " --private-window"),           { description = "Open private browser window" })
    hl.bind(mainMod .. " + C",             hl.dsp.exec_cmd(editor),                                   { description = "Open code editor" })
    hl.bind(mainMod .. " + M",             hl.dsp.exec_cmd("spotify"),                        { description = "Launch Spotify" })
    hl.bind(mainMod .. " + G",             hl.dsp.exec_cmd(game),                                     { description = "Launch Steam/Games" })
    hl.bind(mainMod .. " + P",             hl.dsp.exec_cmd(colorPicker .. " --autocopy"),             { description = "Launch color picker" })

    -- --- Wallpapers ---
    hl.bind(mainMod .. " + W",             hl.dsp.exec_cmd("~/.config/hypr/scripts/random_wallpaper.sh"),  { description = "Set random wallpaper" })
    hl.bind(mainMod .. " + SHIFT + W",     hl.dsp.exec_cmd("~/.config/hypr/scripts/rofi-wallpaper-launcher.sh"),{ description = "Open wallpaper selector" })


    -- --- System ---
    hl.bind(mainMod .. " + L",             hl.dsp.exec_cmd("~/.config/hypr/scripts/lock.sh"),                                     { locked = true, description = "Lock screen" })
    hl.bind("CTRL + Escape",               hl.dsp.exec_cmd("killall waybar || waybar"),                     { description = "Toggle Waybar" })
    hl.bind(mainMod .. " + Escape",        hl.dsp.exec_cmd("pkill wlogout || wlogout --buttons-per-row=5"), { locked = true, description = "Open logout menu" })
    hl.bind("ALT + SHIFT + SPACE", function()
    hl.exec_cmd([[
        DEVICE=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')
        hyprctl switchxkblayout "$DEVICE" next
        LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
        dunstify -a "keyboard" -r 91190 "Keyboard" "Layout : $LAYOUT"
    ]])
end, { description = "Switch keyboard layout (language)" })

    -- --- Rofi ---
    hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/scripts/rofi-binds-cheatsheet.sh"),  { description = "Show keybinds cheatsheet" })
    hl.bind(mainMod .. " + SPACE",         hl.dsp.exec_cmd("pkill rofi || ~/.config/rofi/launchers/type-1/launcher.sh -drun -terminal kitty"), { description = "Open app launcher" })
    hl.bind(mainMod .. " + equal",         hl.dsp.exec_cmd("pkill rofi || rofi -show calc -config " .. rofi_theme),                            { description = "Open calculator" })
    hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/scripts/rofi-emoji-picker.sh"),    { description = "Open emoji picker" })
    hl.bind(mainMod .. " + ALT + SPACE",   hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/scripts/rofi-nerd-icon-selector.sh"),    { description = "Open Nerd Icon picker" })
    hl.bind(mainMod .. " + V",             hl.dsp.exec_cmd("pkill rofi || rofi -show clipboard -modi clipboard:~/.config/hypr/scripts/cliphist-rofi-img.sh -show-icons -config " .. rofi_theme), { description = "Open clipboard manager" })
    hl.bind(mainMod .. " + CTRL + W",      hl.dsp.exec_cmd("pkill rofi || ~/.config/hypr/scripts/rofi-themes-waybar.sh"),{ description = "Set a waybar theme" })

    -- --- Move Focus ---
    hl.bind(mainMod .. " + left",          hl.dsp.focus({ direction = "left"  }),                     { description = "Focus left" })
    hl.bind(mainMod .. " + right",         hl.dsp.focus({ direction = "right" }),                     { description = "Focus right" })
    hl.bind(mainMod .. " + up",            hl.dsp.focus({ direction = "up"    }),                     { description = "Focus up" })
    hl.bind(mainMod .. " + down",          hl.dsp.focus({ direction = "down"  }),                     { description = "Focus down" })
    hl.bind("ALT + Tab", function()
        hl.dispatch(hl.dsp.window.cycle_next())   
        hl.dispatch(hl.dsp.window.bring_to_top()) 
    end, { description = "Cycle to next window" })
    hl.bind(mainMod .. " + T",             hl.dsp.window.float({ action = "toggle" }),                { description = "Toggle floating mode" })

-- --- Resize Windows ---
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true}), { repeating = true, description = "Expand window right" })
    hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true}), { repeating = true, description = "Expand window left" })
    hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true}), { repeating = true, description = "Expand window down" })
    hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true}), { repeating = true, description = "Expand window up"  })
        
    hl.bind(mainMod .. " + J",             hl.dsp.layout("togglesplit"),               { description = "Toggle split direction" }) 
    
    -- --- Move Active Window ---
    hl.bind(mainMod .. " + SHIFT + CTRL + left",  hl.dsp.window.move({ direction = "left"  }), { repeating = true, description = "Move window left" })
    hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ direction = "right" }), { repeating = true, description = "Move window right" })
    hl.bind(mainMod .. " + SHIFT + CTRL + up",    hl.dsp.window.move({ direction = "up"    }), { repeating = true, description = "Move window up" })
    hl.bind(mainMod .. " + SHIFT + CTRL + down",  hl.dsp.window.move({ direction = "down"  }), { repeating = true, description = "Move window down" })

    -- --- Switch Workspaces (AZERTY) ---
    for i = 1, 10 do
        local code = "code:" .. (9 + i) 
        hl.bind(mainMod .. " + " .. code,         hl.dsp.focus({ workspace = i }),                        { description = "Focus workspace " .. i })
        hl.bind(mainMod .. " + SHIFT + " .. code, hl.dsp.window.move({ workspace = i }),                  { description = "Move window to workspace " .. i })
        hl.bind(mainMod .. " + ALT + " .. code,   hl.dsp.window.move({ workspace = i, follow = false }),   { description = "Silently move window to workspace " .. i })
    end

    hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }), { description = "Focus next workspace" })
    hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ workspace = "r-1" }), { description = "Focus previous workspace" })

    -- --- Scratchpad ---
    hl.bind(mainMod .. " + A",          hl.dsp.workspace.toggle_special("magic"),                           { description = "Toggle magic scratchpad" })
    hl.bind(mainMod .. " + SHIFT + A",  hl.dsp.window.move({ workspace = "special:magic" }),                { description = "Move window to magic scratchpad" })
    hl.bind(mainMod .. " + ALT + A",    hl.dsp.window.move({ workspace = "special:magic", follow = false }), { description = "Silently move window to magic scratchpad" })

    -- --- Scroll Workspaces ---
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to next workspace" })
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to previous workspace" })

    -- --- Mouse Window Controls ---
    hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true, description = "Drag window" })
    hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })

    -- --- Audio Volume ---
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("media-control volume_up"),   { locked = true, repeating = true, description = "Raise volume" })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("media-control volume_down"), { locked = true, repeating = true, description = "Lower volume" })
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("media-control volume_mute"), { locked = true, repeating = true, description = "Toggle audio mute" })
    hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("media-control mic_mute"),    { locked = true, repeating = true, description = "Toggle mic mute" })

    -- --- Brightness ---
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("media-control brightness_up"),   { locked = true, repeating = true, description = "Raise brightness" })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("media-control brightness_down"), { locked = true, repeating = true, description = "Lower brightness" })

    -- --- Media (SUPER + Volume keys combo) ---
    hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("media-control next"),       { locked = true, description = "Next track" })
    hl.bind(mainMod .. " + XF86AudioMute",        hl.dsp.exec_cmd("media-control play_pause"), { locked = true, description = "Play/Pause" })
    hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("media-control prev"),       { locked = true, description = "Previous track" })

    -- --- Media (Dedicated media keys) ---
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("media-control next"),       { locked = true, description = "Next track" })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("media-control play_pause"), { locked = true, description = "Pause track" })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("media-control play_pause"), { locked = true, description = "Play track" })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("media-control prev"),       { locked = true, description = "Previous track" })
    hl.bind("XF86Launch6", hl.dsp.exec_cmd("media-control mic_mute"), { locked = true, repeating = true, description = "Toggle mic mute" })
    
    -- --- Screenshots ---
    hl.bind(mainMod .. " + SHIFT + S",        hl.dsp.exec_cmd("grimblast --freeze --notify copysave area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"),   { description = "Capture selected area" })
    hl.bind(mainMod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd("grimblast --notify copysave screen ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"), { locked=true,description = "Capture full screen" })

end