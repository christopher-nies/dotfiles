#!/bin/bash

# Restart hyprland-autoname-workspaces.
# -w waits for the old instance to exit: it holds a single-instance lock,
# and a new one started too early sees the lock and quits.
killall -q -w hyprland-autoname-workspaces

# Absolute path: Hyprland's PATH lacks ~/.local/bin, and a stale
# pre-Lua v1.1.15 copy still sits in /usr/bin.
"$HOME/.local/bin/hyprland-autoname-workspaces" &
