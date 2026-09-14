# Touticouanti

**A Hyprland config, tailored for AZERTY laptops on Arch Linux.**

[![OS](https://img.shields.io/badge/OS-Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white)](https://archlinux.org)
[![Compositor](https://img.shields.io/badge/WM-Hyprland_(Lua)-33ccff?style=flat-square)](https://hyprland.org)
[![Layout](https://img.shields.io/badge/Keyboard-French_AZERTY-blue?style=flat-square)](#-keybindings)
[![Dotfiles](https://img.shields.io/badge/Managed_by-chezmoi-green?style=flat-square&logo=chezmoi&logoColor=white)](https://chezmoi.io)

<!-- Replace with your actual rice previews -->
<!-- <p align="center"><img src="assets/preview.png" width="90%" alt="Desktop Preview" /></p> -->

</div>

---

## Overview

**Touticouanti** is an Arch Linux dotfile suite built for Hyprland. It integrates **Matugen** to generate dynamic Material Design color palettes from your wallpaper.

It is designed primarily for **laptops equipped with French AZERTY keyboards**.

---

## Core Stack

| Layer | Component | Notes |
|---|---|---|
| **Compositor** | Hyprland | Configured via Lua + scripts |
| **Status Bar** | Waybar | Has (for now) 2 configs switchable with ``SUPER + CTRL + W`` |
| **Theme Engine** | Matugen | Extracts color palettes from wallpapers; applies system-wide |
| **Application Launcher** | Rofi-Wayland | App runner, clipboard history, emoji/icon picker, calculator and keybind cheatsheet |
| **Terminal & Shell** | Kitty + Fish / Starship | Terminal with fastfetch at launch |
| **File Manager** | Yazi | Terminal file manager, now supports drag and drop !|
| **Session & Lock** | Hyprlock + Hypridle + Wlogout | Lock screen, Idle management, Power menu |
| **Displays** | `hyprmoncfg` + `hyprsunset` | Display profile switcher and blue light filter |

---

## Installation

### 1. Install Dependencies

Using an AUR helper like `yay`:

```bash
# Core Compositor, Display, & Shell
yay -S --needed hyprland hypridle hyprlock hyprsunset hyprpicker xdg-desktop-portal-hyprland polkit-gnome chezmoi fish starship kitty

# Dynamic Theming & Engine
yay -S --needed matugen-bin kvantum qt5ct qt6ct nwg-look aww-git

# Bar, Launcher, & UI
yay -S --needed waybar-git rofi-wayland wlogout dunst rofimoji cliphist wl-clipboard playerctl grimblast-git btop cava mpv zathura zathura-pdf-mupdf blueman firefox pavucontrol

# File Manager & Portal Picker
yay -S --needed yazi xdg-desktop-portal-termfilechooser-git

# Typography & Icons
yay -S --needed ttf-jetbrains-mono-nerd papirus-icon-theme

```

> **Nvidia Users:** Follow the [Hyprland Nvidia Setup Guide](https://wiki.hyprland.org/Nvidia/) to ensure proper environment variables (`LIBVA_DRIVER_NAME`, `GBM_BACKEND`) are loaded in your display manager.

### 2. Deploy Dotfiles with Chezmoi

```bash
chezmoi init --apply https://github.com/Zulio-b/dotfiles.git

```

### 3. Set Default Shell & Reload Fonts

```bash
chsh -s /usr/bin/fish
fc-cache -fv

```

### 4. First Boot & Color Generation

Log into Hyprland. Generate your initial palette by changing wallpaper ``` SUPER + W ``` (random) or `` SUPER + MAJ + W ``

---

## Keybindings (AZERTY Layout)

Keybindings map natively to the French AZERTY, those are a few practicle examples.

| Keybinding | Action |
| --- | --- |
| `SUPER + Shift + ?` | View all keybindings inside Rofi cheatsheet |
| `SUPER + Enter` | Open Kitty terminal |
| `SUPER + Space` | Application launcher (Rofi) |
| `SUPER + E` | Open Yazi file manager |
| `SUPER + Q` | Close active window |
| `SUPER + L` | Lock screen (`hyprlock`) |
| `SUPER + Shift + W` | Open wallpaper selector (triggers Matugen regeneration) |
| `SUPER + [1-9, 0]` | Switch to workspace |
| `SUPER + Shift + [1-9, 0]` | Move focused window to workspace |

## General info


* **Yazi implementation in firefox:** 
Use this [xdg-desktop-portal-termfilechooser](https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser?tab=readme-ov-file#installation) to replace firefox default file picker with yazi. 

* **General info:** 
This is my personal hyprland config so what works for me might not work for you, and i won't provide support.
Feel free to use whatever you want BUT **⚠️ Make sure you know what you're doing. Do not use anyone's code if you don't understand it ⚠️**

---

## License

Distributed under the [MIT License](https://www.google.com/search?q=LICENSE).

