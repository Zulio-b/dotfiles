# Désactiver le message de bienvenue par défaut
set -g fish_greeting

# Définir VS Code comme éditeur par défaut pour le terminal et chezmoi
set -gx EDITOR "code --wait"
set -gx VISUAL "code --wait"

# Ajout des répertoires locaux au PATH
fish_add_path ~/.dotnet/tools ~/.spicetify

# Lancement des utilitaires visuels
starship init fish | source
fastfetch
