#!/usr/bin/env bash
# hypr-cheatsheet.sh — Hyprland keybindings cheatsheet in rofi

ROFI_THEME="$HOME/.config/rofi/launchers/type-1/style-3.rasi"
KEYBINDS_FILE="${1:-$HOME/.config/hypr/hyprland.conf}"

python3 - "$KEYBINDS_FILE" <<'EOF' | rofi \
    -dmenu \
    -i \
    -p "⌨️  Keybinds" \
    -config "$ROFI_THEME" \
    -no-custom \
    -theme-str '
        window {
            width: 680px;
            height: 600px;
            location: center;
            anchor: center;
            x-offset: 0;
            y-offset: 0;
            fullscreen: false;
        }
        listview { lines: 22; scrollbar: true; }
        element-text { font: "JetBrainsMono Nerd Font 11"; }
    ' > /dev/null
import json, sys, re, subprocess

MOD_BITS = [(64,"Super"),(4,"Ctrl"),(8,"Alt"),(1,"Shift")]
def mod_str(mask):
    return " + ".join(n for v,n in MOD_BITS if mask & v)

KEY_MAP = {
    "return":"Enter","space":"Space","escape":"Esc","delete":"Del",
    "tab":"Tab","equal":"=","minus":"-","comma":",","slash":"/","question":"?",
    "left":"←","right":"→","up":"↑","down":"↓",
    "ampersand":"&","eacute":"é","quotedbl":'"',"apostrophe":"'",
    "parenleft":"(","egrave":"è","underscore":"_","ccedilla":"ç","agrave":"à",
    "mouse_down":"Scroll↓","mouse_up":"Scroll↑",
    "xf86audioraisevolume":"Vol↑","xf86audiolowervolume":"Vol↓",
    "xf86audiomute":"Mute","xf86audiomicmute":"MicMute",
    "xf86monbrightnessup":"Bright↑","xf86monbrightnessdown":"Bright↓",
    "xf86audionext":"Next","xf86audiopause":"Pause",
    "xf86audioplay":"Play","xf86audioprev":"Prev",
}
def pretty_key(k):
    return KEY_MAP.get(k.lower(), k.upper() if len(k)==1 else k)

# --- Parse config to get section per bind (by line order) ---
conf_file = sys.argv[1]
section_map = {}   # (modmask_set, key_lower) -> section
sections_seen = []
current_section = "General"

MAINMOD = 64  # SUPER

def parse_modstr(raw):
    raw = raw.upper().replace("$MAINMOD","SUPER").replace("$WIN","SUPER")
    mask = 0
    if "SUPER" in raw: mask |= 64
    if "SHIFT" in raw: mask |= 1
    if "CTRL" in raw or "CONTROL" in raw: mask |= 4
    if "ALT" in raw:   mask |= 8
    return mask

try:
    with open(conf_file) as f:
        for line in f:
            m = re.match(r'^\s*#\s*---\s*(.+?)\s*---', line)
            if m:
                current_section = m.group(1)
                if current_section not in sections_seen:
                    sections_seen.append(current_section)
                continue
            m = re.match(r'^\s*bindd\S*\s*=\s*([^,]+),\s*([^,]+),', line)
            if m:
                mask = parse_modstr(m.group(1))
                key  = m.group(2).strip().lower()
                section_map[(mask, key)] = current_section
except FileNotFoundError:
    pass

# --- Get binds from hyprctl ---
raw = subprocess.check_output(["hyprctl","binds","-j"])
data = json.loads(raw)

grouped = {}
order = []

for b in data:
    desc = b.get("description","").strip()
    key  = b.get("key","").strip()
    mask = b.get("modmask", 0)
    if not desc or not key:
        continue

    section = section_map.get((mask, key.lower()), "General")

    if section not in grouped:
        grouped[section] = []
        order.append(section)
    grouped[section].append((desc, mod_str(mask), pretty_key(key)))

# --- Output ---
final_order = [s for s in sections_seen if s in grouped]
final_order += [s for s in order if s not in final_order]

first = True
for section in final_order:
    binds = grouped.get(section, [])
    if not binds:
        continue
    if not first:
        print("")
    print(f"── {section}")
    first = False
    for desc, mod, key in binds:
        combo = f"{mod} + {key}" if mod else key
        print(f"  {desc:<40}{combo}")
EOF
