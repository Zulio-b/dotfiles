#!/usr/bin/env bash

tmp_dir="$HOME/.cache/cliphist-rofi"

if [[ -n "$1" ]]; then
    cliphist decode <<<"$1" | wl-copy
    
    # Element is an image
    if echo "$1" | grep -iqE "binary.*(jpg|jpeg|png|bmp)"; then
        id=$(echo "$1" | awk '{print $1}')
        ext=$(echo "$1" | grep -ioE "(jpg|jpeg|png|bmp)" | head -n 1)
        
        img_path="$tmp_dir/${id}.${ext}"        
        notify-send -t 2000 -i "$img_path" "Clipboard" "Image copied"
    else
        preview=$(echo "$1" | cut -f 2-)
        notify-send -t 2000 "Clipboard" "Copied: $preview"
    fi
    
    exit
fi

rm -rf "$tmp_dir"
mkdir -p "$tmp_dir"

read -r -d '' prog <<EOF
/^[0-9]+\s<meta http-equiv=/ { next }
match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
    print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
    next
}
1
EOF
cliphist list | gawk "$prog"