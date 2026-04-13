#!/bin/bash
#  ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
#  ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
#  ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
#  ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
#  ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#   ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles
#	Info    - This script runs the rofi launcher, to select
#             the wallpapers included in the theme you are in.



# Set some variables
wall_dir="${HOME}/Pictures/wallpapers/"
cacheDir="${HOME}/.cache/jp/${theme}"
rofi_command="rofi -x11 -dmenu -theme ${HOME}/.config/hypr/scripts/wallSelect.rasi -theme-str ${rofi_override}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi


physical_monitor_size=24
monitor_res=$(hyprctl monitors |grep -A2 Monitor |head -n 2 |awk '{print $1}' | grep -oE '^[0-9]+')

# --- CORRECTION "bc" ---
# Ajout d'une vérification pour s'assurer que 'bc' est installé et fonctionne
if command -v bc &> /dev/null; then
    dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
else
    echo "ATTENTION: 'bc' n'est pas installé. Utilisation de la valeur par défaut 96 DPI." >&2
    dotsperinch=96
fi

# Sécurité anti-division par zéro
if [ -z "$dotsperinch" ] || [ "$dotsperinch" -eq 0 ]; then
    echo "ATTENTION: Calcul DPI échoué. Utilisation de la valeur par défaut 96 DPI." >&2
    dotsperinch=96
fi
# --- FIN CORRECTION "bc" ---

monitor_res=$(( $monitor_res * $physical_monitor_size / $dotsperinch ))
rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"


# --- CORRECTION SYNTAXE "magick" ---
# Convert images in directory and save to cache dir
find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r imagen; do
    if [ -f "$imagen" ]; then
        nombre_archivo=$(basename "$imagen")
        if [ ! -f "${cacheDir}/${nombre_archivo}" ] || [ "$imagen" -nt "${cacheDir}/${nombre_archivo}" ]; then
            
            # L'image source "$imagen" DOIT venir AVANT les opérations
            magick "$imagen" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
            
            if [ $? -ne 0 ]; then
                echo "ERREUR: magick a échoué pour $imagen" >&2
                rm -f "${cacheDir}/${nombre_archivo}"
            fi
        fi
    fi
done
# --- FIN CORRECTION SYNTAXE "magick" ---


# Select a picture with rofi
wall_selection=$(find "${wall_dir}"  -maxdepth 1  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

# Set the wallpaper
[[ -n "$wall_selection" ]] || exit 1
awww img "${wall_dir}/${wall_selection}" \
        --transition-type "any" \
        --transition-duration 1.5 \
        --transition-fps 60;
matugen image ${wall_dir}/${wall_selection} --source-color-index 0

exit 0