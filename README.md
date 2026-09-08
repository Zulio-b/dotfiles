# Touticouanti

**Material You dynamic theming on Hyprland, tailored for AZERTY laptops on Arch Linux.**

[![OS](https://img.shields.io/badge/OS-Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white)](https://archlinux.org)
[![Compositor](https://img.shields.io/badge/WM-Hyprland_(Lua)-33ccff?style=flat-square)](https://hyprland.org)
[![Layout](https://img.shields.io/badge/Keyboard-French_AZERTY-blue?style=flat-square)](#-keybindings)
[![Dotfiles](https://img.shields.io/badge/Managed_by-chezmoi-green?style=flat-square&logo=chezmoi&logoColor=white)](https://chezmoi.io)

<!-- Replace with your actual rice previews -->
<!-- <p align="center"><img src="assets/preview.png" width="90%" alt="Desktop Preview" /></p> -->

</div>

---

## Overview

**Touticouanti** is an Arch Linux dotfile suite built around Hyprland, configured entirely through modular Lua tables. It integrates **Matugen** to generate dynamic Material Design color palettes across GTK, Qt, terminal, lock screen, and system bars directly from the active wallpaper.

It is designed primarily for **laptops equipped with physical French AZERTY keyboards**, providing native numeric row navigation, battery-aware power handling, and lightweight system monitors.

---

## Core Stack

| Layer | Component | Notes |
|---|---|---|
| **Compositor** | Hyprland | Configured via modular Lua scripts |
| **Status Bar** | Waybar | Battery, audio, network, and dynamic Matugen styles |
| **Theme Engine** | Matugen + Kvantum | Extracts color palettes from wallpapers; applies system-wide |
| **Application Launcher** | Rofi-Wayland | App runner, clipboard history, emoji/icon picker, calculator and keybind cheatsheet |
| **Terminal & Shell** | Kitty + Fish / Starship | Synchronized terminal colors with persistent shell utilities |
| **File Manager** | Yazi | Terminal file manager with `termfilechooser` portal integration |
| **Session & Lock** | Hyprlock + Hypridle + Wlogout | Lock screen shows media controls, capslock, and battery telemetry |
| **Displays** | `hyprmoncfg` + `hyprsunset` | Display profile switcher and blue light filter |

---

## Installation

### 1. Install Dependencies

Using an AUR helper like `yay`:

```bash
# Core Compositor, Display, & Shell
yay -S --needed hyprland hypridle hyprlock hyprsunset hyprpicker \
    xdg-desktop-portal-hyprland polkit-gnome chezmoi fish starship kitty

# Dynamic Theming & Engine
yay -S --needed matugen-bin kvantum qt5ct qt6ct nwg-look swww

# Bar, Launcher, & UI
yay -S --needed waybar rofi-wayland wlogout dunst rofimoji cliphist wl-clipboard \
    playerctl grimblast-git btop cava mpv zathura zathura-pdf-mupdf

# File Manager & Portal Picker
yay -S --needed yazi xdg-desktop-portal-termfilechooser-git

# Typography & Icons
yay -S --needed ttf-jetbrains-mono-nerd papirus-icon-theme

```

> **Nvidia Users:** Follow the [Hyprland Nvidia Setup Guide](https://wiki.hyprland.org/Nvidia/) to ensure proper environment variables (`LIBVA_DRIVER_NAME`, `GBM_BACKEND`) are loaded in your display manager.

### 2. Deploy Dotfiles with Chezmoi

```bash
chezmoi init --apply [https://github.com/](https://github.com/)<YOUR_USERNAME>/<YOUR_REPO_NAME>.git

```

### 3. Set Default Shell & Reload Fonts

```bash
chsh -s /usr/bin/fish
fc-cache -fv

```

### 4. First Boot & Color Generation

Log into Hyprland. Generate your initial palette by running the wallpaper launcher:

```bash
~/.config/hypr/scripts/rofi-wallpaper-launcher.sh

```

---

## Keybindings (AZERTY Layout)

Keybindings map natively to the French AZERTY top row without requiring manual keycode workarounds.

| Keybinding | Action |
| --- | --- |
| `SUPER + Enter` | Open Kitty terminal |
| `SUPER + Space` | Application launcher (Rofi) |
| `SUPER + E` | Open Yazi file manager |
| `SUPER + Q` | Close active window |
| `SUPER + L` | Lock screen (`hyprlock`) |
| `SUPER + Shift + W` | Open wallpaper selector (triggers Matugen regeneration) |
| `SUPER + Shift + ?` | View all keybindings inside Rofi cheatsheet |
| `SUPER + [1-9, 0]` | Switch to workspace (`&`, `é`, `"`, `'`, `(`, `-`, `è`, `_`, `ç`, `à`) |
| `SUPER + Shift + [1-9, 0]` | Move focused window to workspace |

---

## File Structure

```text
~/.config/
├── hypr/
│   ├── hyprland.lua           # Master compositor configuration
│   ├── modules/               # Modular Lua config (binds, rules, monitors)
│   ├── hyprlock/              # Lockscreen layouts and status scripts
│   └── scripts/               # Wallpaper pickers, battery monitors, theme reloaders
├── matugen/                   # Color scheme templates for GTK, Qt, Waybar, etc.
├── waybar/                    # Status bar themes and widgets
├── rofi/                      # Applets, launchers, and icon lists
├── yazi/                      # Keymaps and package definitions
└── fish/                      # Shell functions and autostart variables

```

---

## Troubleshooting & Maintenance

* **GTK/Qt Theme Synchronization:** If GTK apps fail to match your active Matugen palette after changing wallpapers, trigger the reload script manually:
```bash
~/.config/hypr/scripts/theme-gtk.sh

```


* **Waybar Template Warnings:** Do not overwrite `.config/waybar/config.jsonc` using raw `chezmoi add`. Modify it using `chezmoi edit ~/.config/waybar/config.jsonc` to preserve dynamic template variables.

---

## License

Distributed under the [MIT License](https://www.google.com/search?q=LICENSE).

