# Touticouanti — A Matugen-powered, AZERTY laptop-aimed Hyprland Rice

> A dynamic Hyprland environment with **native AZERTY** support and automatic **Matugen** theming.

> ⚠️ Designed for Arch Linux + Wayland with intel cpu. May require adaptation on other setups.

![OS](https://img.shields.io/badge/OS-Arch_Linux-1793D1?style=flat-square)
![WM](https://img.shields.io/badge/WM-Hyprland-33ccff?style=flat-square)
![Layout](https://img.shields.io/badge/Layout-AZERTY--FR-ff4444?style=flat-square)
![Manager](https://img.shields.io/badge/Managed_by-Chezmoi-green?style=flat-square)

<p align="center">
  <img src="assets/blue.png" width="48%" />
  <img src="assets/green.png" width="48%" />
</p>

### 🎥 Live Demo (Dynamic Theming & Rofi)
<video src="https://github.com/le-pape/dotfiles/raw/main/assets/video.mp4" width="100%" controls autoplay loop></video>
---

## 🧩 The Stack

- **WM:** Hyprland
- **Theming:** Matugen (Colors) & Kvantum (Qt)
- **Bar:** Waybar
- **Launcher & Menus:** Rofi (Wayland fork)
- **Terminal:** Kitty 
- **Shell:** Fish
- **Wallpaper Engine:** Awww
- **Dotfiles Manager:** Chezmoi

---

## ✨ Features

- 🇫🇷 **Native AZERTY:** No more weird keyboard mapping issues (`& é " ' ...` work out of the box for workspaces).
- 💻 **Laptop Oriented:** Configured for trackpad gestures, brightness/volume OSDs, and power profiles.
- 🎨 **Dynamic Theming:** Powered by Matugen. Change your wallpaper and watch your entire system (Waybar, Rofi, Kitty, Spotify) adapt instantly.
- ⌨️ **Command Palette:** Rofi-powered command palette (apps, calculator, power menu, cheat sheet).
- ⚙️ **Seamless Deployment:** Effortless installation via `chezmoi`.

---

## 🚀 Installation

### 1. Install Dependencies
Make sure you install all the required packages (using `yay` or your preferred AUR helper):

```bash
# Core & Window Manager
yay -S hyprland awww-git matugen-bin chezmoi

# UI, Fonts & Theming
yay -S waybar rofi-lbonn-wayland-git wlogout swaync \
       nwg-look-bin qt5ct qt6ct kvantum \
       bibata-cursor-theme-bin papirus-icon-theme \
       ttf-jetbrains-mono-nerd

# Terminal & Shell
yay -S kitty fish starship fastfetch

# System & Hardware (Audio, Bluetooth, Network, Power)
yay -S pavucontrol-qt blueman networkmanager power-profiles-daemon btop htop

# Apps, Multimedia & Utilities
yay -S firefox dolphin spotify-launcher spicetify-cli cava \
       swayosd-git hyprlock hypridle hyprsunset hyprpicker \
       grimblast-git wl-clipboard cliphist playerctl dunst
```
Then set fish as your default shell with 
```bash
chsh -s /usr/bin/fish
```

Thanks to the power of `chezmoi`, once the dependencies are installed, just run:
```bash
chezmoi init --apply https://github.com/le-pape/dotfiles.git
```
**and voilà 💫 !**
Log out and log back in to ensure all environment variables are applied. Once inside, press SUPER + W to set a wallpaper and let Matugen's magic work!

---
## 🛠️ Post-Install Notes
**1.Enable Spotify Theming**

Spotify needs to be initialized before Spicetify can theme it. Run this in your terminal:
```bash
spotify-launcher  # Run once to download and set up Spotify folders
spicetify backup apply
```
**2.Enable VSCode Theming**
*Disclaimer : not very readable code* \
If you want matugen colored vscode just install this extension : ```ext install HyprLuna.hyprluna-theme```, do as it says and enjoy !


---


## 🎮 Shortcuts

Don't want to memorize everything? Press `SUPER` + `SHIFT` + `?` to open the interactive Rofi Cheat Sheet!

| Action      | Key                 |
| ----------- | ------------------- |
| Terminal    | `SUPER + Enter`     |
| Launcher    | `SUPER + Space`     |
| Wallpaper   | `SUPER + SHIFT + W` |
| Cheat Sheet | `SUPER + SHIFT + ?` |
| Close       | `SUPER + Q`         |

---


## 📂 Structure

A quick overview of the main components managed by `chezmoi`:

```text
~/.config/
├── hypr/       # Brain of the system (bindd, window rules, startup)
├── matugen/    # Templates that generate colors for the whole system
├── waybar/     # Status bar styling and custom modules
├── rofi/       # Interactive menus (launcher, cheat sheet, calculator)
├── kitty/      # Terminal configuration
└── Kvantum/    # Qt application theming engine
```

---

## 🎯 Roadmap & Upcoming Features

- [ ] **New Visual Identity:** Find and integrate an alternative icon/UI theme to Breeze ; while ensuring seamless synchronization with Matugen's generated colors.
- [ ] **Dynamic Keyboard Layout Switch:** Implement an on-the-fly layout toggle (e.g., AZERTY ↔ QWERTY) that automatically updates Hyprland keybinds without requiring a session restart.
- [ ] **Power Profiles & Animations:** Set up smart battery optimization based on power state (plugged in vs. on battery).

## 🙏 Acknowledgement

Huge thanks to the entire Linux ricing community. I have used, learned from, and been inspired by so many incredible dotfiles to build this one.

## 📜 License

MIT
