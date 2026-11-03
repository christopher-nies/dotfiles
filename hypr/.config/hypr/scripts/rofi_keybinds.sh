#!/bin/bash

# Keybind cheat sheet for the Lua config (Hyprland 0.57+).
# Lists every single-line hl.bind(...) in hyprland.lua; picking one runs it.
# Originally based on: https://github.com/jason9075/rofi-hyprland-keybinds-cheatsheet

HYPR_CONF="$HOME/.config/hypr/hyprland.lua"

# The config's top-level `local x = ...` lines (terminal, home, mainMod, ...),
# sent along so the chosen action resolves the same way it does in the config.
PRELUDE=$(grep -E '^local [A-Za-z_]+ *= ' "$HYPR_CONF")

# One row per bind: KEYS<TAB>ACTION  (mouse binds and the 1-10 loop are skipped)
mapfile -t BINDINGS < <(
    grep -E '^hl\.bind\(.*\)$' "$HYPR_CONF" | grep -v 'mouse' |
    sed -E 's/^hl\.bind\((.*)\)$/\1/' |
    sed -E 's/^mainMod \.\. "( \+ )?/"SUPER + /; s/^Mod \.\. "( \+ )?/"ALT + /' |
    sed -E 's/^"([^"]*)", (.*)$/\1\t\2/' |
    sed -E 's/, \{[^}]*\}$//' |
    grep -P '^[^"\t]+\t'
)

[ ${#BINDINGS[@]} -eq 0 ] && { notify-send "Keybinds" "No binds found in $HYPR_CONF"; exit 1; }

INDEX=$(printf '%s\n' "${BINDINGS[@]}" |
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g' |
    awk -F'\t' '{ printf "<b>%s</b>  <span color=\x27gray\x27>%s</span>\n", $1, $2 }' |
    rofi -dmenu -i -markup-rows -format i -p "Hyprland Keybinds")

[ -z "$INDEX" ] && exit 0

ACTION=$(printf '%s\n' "${BINDINGS[$INDEX]}" | cut -f2-)

hyprctl eval "$PRELUDE
hl.dispatch($ACTION)"
