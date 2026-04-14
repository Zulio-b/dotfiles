Hyprazerty — Automated Material You & Native AZERTY

    Un environnement Hyprland dynamique, élégant et entièrement pensé pour les claviers français. Changez de fond d'écran et regardez l'intégralité de votre système s'adapter en temps réel.

(📸 Conseil : Ajoute ici 2 ou 3 captures d'écran de ton bureau avec des couleurs différentes pour montrer l'effet Matugen)
✨ Pourquoi HyprLuna ?

Le problème de 99 % des rices Hyprland ? Ils sont conçus pour le QWERTY. HyprLuna résout ce problème à la racine tout en offrant une esthétique de pointe.

    🇫🇷 Native AZERTY : Fini la gymnastique pour changer de bureau. Les workspaces sont mappés sur les codes matériels de vos touches (&, é, ", '...).

    🎨 Harmonie Matugen : Le moteur awww change le wallpaper, Matugen extrait la palette, et vos applications (GTK, Qt, Waybar, Rofi, Kitty, Spotify) changent de couleur instantanément.

    ⌨️ Command Palette Intégrée : Oubliez la mémorisation des raccourcis. Un menu Rofi généré dynamiquement lit votre configuration et affiche tous vos binds (avec descriptions !).

    ⚙️ Architecture DevOps : Entièrement géré par chezmoi. Un seul coup de commande pour déployer ou sauvegarder votre système.

🚀 Installation Rapide
1. Dépendances requises (Arch Linux)

Installez les fondations via votre helper AUR préféré (yay ou paru) :
Bash

# Core & Engine
yay -S hyprland-git awww-git matugen-bin chezmoi

# UI & Style
yay -S waybar-hyprland rofi-lbonn-wayland-git nwg-look-bin qt5ct qt6ct kvantum bibata-cursor-theme-bin papirus-icon-theme

# Multimédia & Utilitaires
yay -S spotify-launcher spicetify-cli swayosd-git hyprlock grimblast-git playerctl

2. Déploiement Magique

Clonez et appliquez toute la configuration d'un seul coup :
Bash

chezmoi init --apply https://github.com/VOTRE_PSEUDO/HyprLuna.git

(N'oubliez pas de recharger Hyprland ou de redémarrer votre session).
🎮 Prise en main & Raccourcis

Plutôt que de lister 50 raccourcis ici, HyprLuna intègre une Cheat Sheet interactive (façon Command Palette).

👉 Appuyez sur SUPER + SHIFT + ? (Touche Virgule) pour afficher tous vos raccourcis en direct, chercher une action et l'exécuter.
Les Basiques :
Action	Raccourci AZERTY
Terminal (Kitty)	SUPER + Entrée
Lanceur d'apps	SUPER + Espace
Changer de Wallpaper	SUPER + W
Gestion Workspaces	SUPER + [1-0] (Touches & à à)
Quitter une fenêtre	SUPER + Q
🛠️ Configuration Avancée
1. L'Harmonie Dolphin (Qt6 & Kvantum)

Pour que vos explorateurs de fichiers respectent le thème dynamique :

    Lancez qt6ct et qt5ct.

    Allez dans l'onglet Apparence.

    Réglez le Style sur kvantum et les icônes sur Papirus ou Breeze.

2. Spotify & Spicetify

Spotify est intégré au moteur de couleurs. Pour l'initialiser après une nouvelle installation :
Bash

spotify-launcher  # Lancez-le une fois pour créer les dossiers
spicetify backup apply

Note : Si Spotify se met à jour, relancez ces commandes.
📂 Structure du Coffre-Fort (chezmoi)

La configuration est pensée pour être modulaire :

    ~/.config/hypr/hyprland.conf : Cerveau du système (raccourcis en bindd).

    ~/.config/hypr/scripts/ : Vos scripts (dont l'incroyable hypr-cheatsheet.sh).

    ~/.config/matugen/templates/ : Les recettes qui permettent de colorer automatiquement vos apps.