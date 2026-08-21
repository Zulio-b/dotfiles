#!/bin/bash

# media.sh - Simple media player info script for hyprlock
# Shows title, artist, source, album art, and playback status.
# Also handles previous/play-pause/next button clicks.
# Everything outputs empty ("") when nothing is playing, so the
# corresponding hyprlock labels/image just disappear.
#
# Usage:
#   media.sh --title      -> song title
#   media.sh --artist     -> artist name
#   media.sh --source     -> Spotify/Firefox/Chrome/etc
#   media.sh --art        -> path to album art image
#   media.sh --status     -> play/pause icon
#   media.sh --previous   -> skip to previous track
#   media.sh --next       -> skip to next track
#   media.sh --play-pause -> toggle play/pause

if [ $# -eq 0 ]; then
    echo "Usage: $0 --title | --artist | --source | --art | --update-art | --status | --previous | --next | --play-pause"
    exit 1
fi

# Get one metadata field from playerctl
get_metadata() {
    playerctl metadata --format "{{ $1 }}" 2>/dev/null
}

# Check whether anything is actively playing or paused.
# Returns 0 (true) if yes, 1 (false) if nothing is playing.
is_active() {
    status=$(playerctl status 2>/dev/null)
    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        return 0
    else
        return 1
    fi
}

case "$1" in

--title)
    if is_active; then
        title=$(get_metadata "xesam:title")
        if [ ${#title} -gt 27 ]; then
            echo "${title:0:25}..."
        else
            echo "$title"
        fi
    else
        echo ""
    fi
    ;;

--artist)
    if is_active; then
        artist=$(get_metadata "xesam:artist")
        if [ ${#artist} -gt 25 ]; then
            echo "${artist:0:22}..."
        else
            echo "$artist"
        fi
    else
        echo ""
    fi
    ;;

--art)
    # Always the SAME fixed path. The image widget in hyprlock.conf
    # should point here directly, with a reload_time so it periodically
    # re-reads the file (see --update-art below, which keeps it fresh).
    echo "$HOME/.cache/hyprlock-art/current.jpg"
    ;;

--update-art)
    art_dir="$HOME/.cache/hyprlock-art"
    art_file="$art_dir/current.jpg"
    blank_file="$art_dir/blank.jpg"
    cache_url_file="$art_dir/last_url.txt" 
    mkdir -p "$art_dir"

    if [ ! -f "$blank_file" ] && command -v magick >/dev/null 2>&1; then
        magick -size 1x1 xc:none "$blank_file" 2>/dev/null
    fi

    if ! is_active; then
        [ -f "$blank_file" ] && cp "$blank_file" "$art_file"
        rm -f "$cache_url_file" # Empty cache if nothing is playing
        exit 0
    fi

    art_url=$(get_metadata "mpris:artUrl")
    [ -z "$art_url" ] && exit 0

    # --- cache verification ---
    if [ -f "$cache_url_file" ]; then
        last_url=$(cat "$cache_url_file")
        if [ "$last_url" = "$art_url" ]; then
            exit 0 
        fi
    fi
    echo "$art_url" > "$cache_url_file"

    if [[ "$art_url" == file://* ]]; then
        local_path="${art_url#file://}"
        [ -f "$local_path" ] && cp "$local_path" "$art_file"

    elif [[ "$art_url" == http* ]]; then
        tmp_file="$art_dir/.tmp_$$.jpg"
        if curl --fail --silent --max-time 5 -o "$tmp_file" "$art_url"; then
            if [ -s "$tmp_file" ]; then
                mv "$tmp_file" "$art_file"
            else
                rm -f "$tmp_file"
            fi
        else
            rm -f "$tmp_file"
        fi
    fi
    ;;
--source)
    if ! is_active; then
        echo ""
        exit 0
    fi

    track_id=$(get_metadata "mpris:trackid")

    if [[ "$track_id" == *"firefox"* ]]; then
        echo "Firefox 󰈹"
    elif [[ "$track_id" == *"spotify"* ]]; then
        echo "Spotify "
    elif [[ "$track_id" == *"chromium"* ]]; then
        echo "Chrome "
    else
        echo ""
    fi
    ;;

--status)
    status=$(playerctl status 2>/dev/null)

    if [ "$status" = "Playing" ]; then
        echo "󰏤"
    elif [ "$status" = "Paused" ]; then
        echo "󰐊"
    else
        echo ""
    fi
    ;;

--previous)
    playerctl previous
    ;;

--next)
    playerctl next
    ;;

--play-pause)
    playerctl play-pause
    ;;

*)
    echo "Invalid option: $1"
    exit 1
    ;;

esac