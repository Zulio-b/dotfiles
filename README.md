# 🥖 Hyprbaguette a Matugen powered, azerty aimed rice

> Hyprland dynamique avec support **AZERTY natif** et thème **Material You automatique**

![OS](https://img.shields.io/badge/OS-Arch_Linux-1793D1?style=flat-square)
![WM](https://img.shields.io/badge/WM-Hyprland-33ccff?style=flat-square)
![Layout](https://img.shields.io/badge/Layout-AZERTY--FR-ff4444?style=flat-square)

---

## ✨ Features

- 🇫🇷 AZERTY natif (`& é " ' ...`)
- 🎨 Thème dynamique (Matugen)
- ⌨️ Cheat sheet automatique (Rofi)
- ⚙️ Déploiement via chezmoi

---

## 🚀 Install

```bash
yay -S hyprland awww-git matugen-bin chezmoi \
       waybar rofi-lbonn-wayland-git nwg-look-bin \
       qt5ct qt6ct kvantum \
       bibata-cursor-theme-bin papirus-icon-theme \
       spotify-launcher spicetify-cli \
       swayosd-git hyprlock grimblast-git playerctl
```

La force de `chezmoi`, une fois les dépendances installées vous avez juste à éxecuter : 

```bash
chezmoi init --apply https://github.com/le-pape/dotfiles.git
```

---

## 🎮 Shortcuts

| Action      | Key                 |
| ----------- | ------------------- |
| Terminal    | `SUPER + Enter`     |
| Launcher    | `SUPER + Space`     |
| Wallpaper   | `SUPER + W`         |
| Cheat Sheet | `SUPER + SHIFT + ,` |
| Close       | `SUPER + Q`         |

---

## 🛠️ Notes

```bash
qt6ct
qt5ct
```

* Style → `kvantum`
* Icons → `Papirus`

```bash
spotify-launcher
spicetify backup apply
```

---

## 📂 Structure

```
~/.config/
├── hypr/
├── matugen/
├── waybar/
├── rofi/
└── kitty/
```

---

## 📜 License

MIT
