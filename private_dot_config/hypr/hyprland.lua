local colors = require("modules.colors")

---------------------
---- MY PROGRAMS ----
---------------------
-- Set programs that you use

local terminal    = "kitty"
local fileManager = "kitty --class 'yazi' -e yazi"
local menu        = "rofi -show drun"
local browser     = "firefox"
local editor      = "code"
local game        = "steam"
local colorPicker = "hyprpicker"


require("modules.monitors")
require("modules.env")
require("modules.autostart")
require("modules.looks")(colors)
require("modules.rules")
require("modules.input")
require("modules.binds")(terminal, fileManager, menu, browser, editor, game, colorPicker)

-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")



----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

