# touticouanti 🇫🇷

> A Hyprland rice built for French AZERTY laptops — because most dotfiles out there assume QWERTY and half your binds end up on the wrong key.

![EndeavourOS](https://img.shields.io/badge/EndeavourOS-Arch--based-7F3FBF?logo=archlinux&logoColor=white)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-58E1FF?logo=wayland&logoColor=white)
![chezmoi](https://img.shields.io/badge/dotfiles-chezmoi-2E6DB4)
![AZERTY](https://img.shields.io/badge/layout-AZERTY-blue)

## What is this

`touticouanti` is my personal Hyprland setup, managed with [chezmoi](https://www.chezmoi.io/) and running on EndeavourOS. It's tuned end-to-end for a French AZERTY laptop keyboard — binds, workspace numbers, symbols, layout switching, all of it — instead of the usual "just remap Ctrl and hope" approach most rices ship with.

Config is written in Lua (Hyprland 0.5x+ Lua config system), themed dynamically with `matugen`, and wrapped in a set of small scripts that handle the stuff Hyprland doesn't do out of the box (smart suspend, lockscreen media widget, layout-switch notifications, etc).

## Why AZERTY needs its own rice

Most Hyprland configs bind workspaces to `1-9` assuming a QWERTY row. On AZERTY, the number row requires holding `Shift`, and symbols (`&é"'(-è_çà)=`) sit in totally different places. `touticouanti` fixes this at the source:

- **Physical keycode binds** for workspaces (`bind = $mod, code:10, workspace, 1`, etc.) instead of symbolic binds, so `1` through `0` always work regardless of which layout is active.
- **`resolve_binds_by_sym = 1`** used selectively for binds that should stay symbol-based (so punctuation-based keybinds resolve correctly per active layout instead of per physical key).
- **Dual-layout switching** (AZERTY ⇄ QWERTY) baked into the keyboard config, with a `dunstify` popup confirming which layout is now active — handy since it's easy to lose track when jumping between a French laptop keyboard and an external QWERTY board.
- Rofi, Waybar, and hyprlock scripts avoid hardcoded QWERTY-only shortcuts.

## Stack

| Component | Tool |
|---|---|
| Distro | EndeavourOS (Arch-based) |
| Compositor | Hyprland (Lua config) |
| Shell | Fish + Starship |
| Terminal | Kitty |
| File manager | Yazi |
| Launcher | Rofi |
| Bar | Waybar |
| Lockscreen | hyprlock |
| Idle/suspend | hypridle + custom smart-suspend logic |
| Notifications | dunst |
| Theming engine | matugen (Material You-style dynamic color) |
| Session/power menu | wlogout |
| Dotfiles manager | chezmoi |

## Highlights

- **Dynamic theming** — `matugen` generates a color palette from the current wallpaper and pushes it into Hyprland, Waybar, Rofi, GTK 3/4, Kitty, dunst, cava, yazi, zathura, qt5ct/qt6ct, Kvantum, hyprlock, and even a Firefox (Pywalfox) theme, all from templates in `.config/matugen/templates/`.
- **hyprlock media widget** — shows currently playing Spotify track with album art (fetched via `curl`, written atomically to a cache path), plus a battery indicator and Caps Lock state. Two lockscreen configs (`hyprlock-player.conf` / `hyprlock-noplayer.conf`) are swapped by `lock.sh` depending on whether media is playing.
- **Smart suspend** — `smart_suspend.sh` + hypridle skip suspending the laptop while audio is actively playing, working around hypridle's one-shot timeout quirks.
- **Rofi everywhere** — app launcher, clipboard history (`cliphist`), emoji picker, Nerd Font icon picker, wallpaper picker with thumbnails, Waybar theme switcher with previews, and a searchable keybind cheatsheet generated straight from the Lua config.
- **Modular Lua config** — `hyprland.lua` pulls in separate modules for binds, monitors, env vars, autostart, animations/looks, window rules, and input, instead of one giant file.
- **Native file dialogs through Yazi** — `xdg-desktop-portal-termfilechooser` routes GTK/Firefox file pickers through Yazi in a floating, centered Hyprland window.

## Repo layout (chezmoi-managed)

```
~/.config/hypr/
├── hyprland.lua              # entrypoint
├── hypridle.conf
├── hyprlock.conf
├── hyprlock/                 # player/no-player configs, fonts, widget scripts
├── modules/                  # binds.lua, monitors.lua, env.lua, input.lua, looks.lua, rules.lua, autostart.lua
└── scripts/                  # lock.sh, smart_suspend.sh, rofi-*.sh, theme-gtk.sh, battery-notify.sh …

~/.config/waybar/             # bars + swappable themes
~/.config/rofi/               # launcher, applets, color schemes
~/.config/matugen/            # dynamic theming engine + templates for every app
~/.config/kitty/  ~/.config/fish/  ~/.config/yazi/
~/.config/dunst/  ~/.config/wlogout/  ~/.config/zathura/
~/.config/gtk-3.0/  ~/.config/gtk-4.0/  ~/.config/qt5ct/  ~/.config/qt6ct/  ~/.config/Kvantum/
~/.config/xdg-desktop-portal-termfilechooser/
~/Pictures/wallpapers/
```

## Install

```bash
chezmoi init --apply <your-github-username>/touticouanti
```

Then reload Hyprland (`hyprctl reload` — mind the 0.55+ dispatch syntax changes if you're on an older config) and pick a wallpaper via `rofi-wallpaper-launcher.sh` to trigger the first `matugen` theme pass.

### Requirements

- Hyprland 0.5x+ (Lua config support)
- `matugen`, `dunst`, `rofi`, `waybar`, `hypridle`/`hyprlock`, `yazi`, `fish`, `starship`, `kitty`
- `xdg-desktop-portal-termfilechooser` for native-feeling Yazi file dialogs
- A French AZERTY keyboard (or at least the willingness to toggle to one)

## Notes

This is a living config — some scripts (Bluetooth headphone wake-on-touch workarounds, etc.) are actively being debugged. Expect rough edges; check commit history for the latest fixes.

## Credits

Built and maintained by Jules, engineering student (SIR — Information Systems) at Polytech Nancy, currently on Erasmus in Warsaw. Inspired by the broader Hyprland ricing community — see individual template/script headers for any borrowed snippets.