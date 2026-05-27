-- hyprland.lua — migrated from hyprland.conf for Hyprland 0.55+
-- Old hyprland.conf is kept as backup; this file takes precedence.

require("monitors")
require("workspaces")


-----------------------
---- MY PROGRAMS ----
-----------------------

local home        = os.getenv("HOME")
local terminal    = "kitty"
local browser     = "brave --disable-features=WaylandWpColorManagerV1"
local fileManager = "thunar"
local launcher    = "walker"
local confDir     = home .. "/.config"
local hyprDir     = confDir .. "/hypr"


-------------------
---- AUTOSTART ----
-------------------

-- exec (runs on both start and config reload)
local function on_reload()
    hl.exec_cmd("elephant")
    hl.exec_cmd("xrdb -merge " .. home .. "/.Xresources")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'gruvbox-dark-gtk'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end

-- exec-once (runs only on Hyprland startup)
hl.on("hyprland.start", function()
    hl.exec_cmd(confDir .. "/waybar/waybar_timer serve m:s")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprland-autoname-workspaces")
    hl.exec_cmd("wlsunset -l 51.2 -L 8.1")
    hl.exec_cmd("ydotoold")
    hl.exec_cmd("nextcloud")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    on_reload()
end)

hl.on("config.reloaded", function()
    on_reload()
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("TERMINAL",                    "kitty")
hl.env("BROWSER",                     "brave")
hl.env("FILE",                        "thunar")
hl.env("FILE_MANAGER",                "thunar")
hl.env("XDG_CURRENT_DESKTOP",         "Hyprland")
hl.env("XCURSOR_SIZE",                "24")
hl.env("XCURSOR_THEME",               "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE",             "24")
hl.env("HYPRCURSOR_THEME",            "Bibata-Modern-Ice")
hl.env("QT_QPA_PLATFORM",             "wayland")
hl.env("QT_QPA_PLATFORMTHEME",        "qt5ct")
hl.env("QT_SCALE_FACTOR",             "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "0")
hl.env("SDL_VIDEODRIVER",             "wayland")
hl.env("CLUTTER_BACKEND",             "wayland")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = "rgb(ebdbb2)",
            inactive_border = "rgb(282828)",
        },

        resize_on_border        = true,
        extend_border_grab_area = 15,
        hover_icon_on_border    = true,

        allow_tearing = false,
        layout        = "dwindle",
    },

    decoration = {
        rounding = 10,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },

        glow = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split    = 2,
    },

    master = {
        new_status     = "slave",
        drop_at_cursor = false,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "us,de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:caps_toggle",
        kb_rules   = "",

        numlock_by_default = true,
        follow_mouse       = 1,
        sensitivity        = 0,

        touchpad = {
            natural_scroll = true,
        },

        tablet = {
            output = "DP-1",
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})


--------------------
---- ANIMATIONS ----
--------------------

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",      enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 7,  bezier = "default",  style = "popin 80%" })
hl.animation({ leaf = "border",       enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",  enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",         enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",   enabled = true, speed = 6,  bezier = "default" })


---------------
---- INPUT ----
---------------

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "tpps/2-ibm-trackpoint",
    sensitivity = -0.3,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local Mod     = "ALT_L"

-- Rofi cheat-sheet
hl.bind(mainMod .. " + A",                hl.dsp.exec_cmd(hyprDir .. "/scripts/rofi_keybinds.sh"))

-- Applications
hl.bind(mainMod .. " + Return",           hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R",               hl.dsp.exec_cmd(terminal .. " ranger"))
hl.bind(mainMod .. " + B",               hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + Return",  hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T",               hl.dsp.exec_cmd("normcap --clipboard-handler wlclipboard"))
hl.bind(mainMod .. " + O",               hl.dsp.exec_cmd(home .. "/bin/latex-ocr"))
hl.bind(mainMod .. " + D",               hl.dsp.exec_cmd(home .. "/bin/nerd-dictation-start-en"))
hl.bind(mainMod .. " + SHIFT + D",       hl.dsp.exec_cmd(home .. "/bin/nerd-dictation-end"))
hl.bind(mainMod .. " + P",               hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | satty -f -"))
hl.bind(mainMod .. " + U",               hl.dsp.exec_cmd(home .. "/bin/zipline-clipboard-uploader.sh"))
hl.bind(mainMod .. " + C",               hl.dsp.exec_cmd("hyprpicker -a -f hex"))
hl.bind(mainMod .. " + SHIFT + N",       hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Launcher / Obsidian / emoji / clipboard
hl.bind(Mod .. " + Space",               hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + Space",           hl.dsp.exec_cmd(home .. "/bin/obsidian_daily_append"))
hl.bind(Mod .. " + SHIFT + Space",       hl.dsp.exec_cmd("rofimoji"))
hl.bind(Mod .. " + SHIFT + V",           hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Session / window management
hl.bind(mainMod .. " + SHIFT + X",       hl.dsp.exec_cmd("archlinux-logout"))
hl.bind(mainMod .. " + Q",               hl.dsp.window.close())
hl.bind(mainMod .. " + V",               hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",               hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + E",               hl.dsp.layout("rotatesplit"))
hl.bind(mainMod .. " + Tab",             hl.dsp.window.cycle_next())

-- Waybar
hl.bind(mainMod .. " + SHIFT + P",       hl.dsp.exec_cmd(confDir .. "/waybar/reload_waybar.sh"))
hl.bind(mainMod .. " + SHIFT + O",       hl.dsp.exec_cmd(confDir .. "/waybar/reload_autoname-workspaces.sh"))

-- Lock
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Focus (vim-style)
hl.bind(mainMod .. " + H",               hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",               hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",               hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",               hl.dsp.focus({ direction = "down" }))

-- Workspace navigation
hl.bind(mainMod .. " + SHIFT + L",       hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + H",       hl.dsp.focus({ workspace = "e-1" }))

-- Switch / move to workspaces 1-10 (0 key = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspaces
hl.bind(mainMod .. " + X",               hl.dsp.workspace.toggle_special("ferdium"))
hl.bind(mainMod .. " + S",               hl.dsp.workspace.toggle_special("spotify"))
hl.bind("SUPER + ALT + G",               hl.dsp.workspace.toggle_special("gromit"))

-- Mouse workspace scroll
hl.bind(mainMod .. " + mouse_down",      hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",        hl.dsp.focus({ workspace = "e-1" }))

-- Mouse move / resize
hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Handy
hl.bind("CTRL + SPACE",                  hl.dsp.exec_cmd("pkill -SIGUSR2 handy"))

-- Media keys (locked + repeating)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume raise"),       { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume lower"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"),          { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"),          { locked = true, repeating = true })

-- Playerctl (locked)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Lid switch (locked)
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind("switch:Lid Switch",    hl.dsp.exec_cmd("hyprlock"),          { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Gromit-mpx special workspace
hl.workspace_rule({
    workspace        = "special:gromit",
    gaps_in          = 0,
    gaps_out         = 0,
    on_created_empty = "gromit-mpx -a",
})

-- Special workspace assignments
hl.window_rule({ match = { class = "^([S|s]potify)" }, workspace = "special:spotify" })
hl.window_rule({ match = { class = "^([F|f]erdium)" }, workspace = "special:ferdium" })

-- Float rules
hl.window_rule({ match = { title = "^(ranger)$" },                               float = true })
hl.window_rule({ match = { title = "^(satty)$" },                                float = true })
hl.window_rule({ match = { class = "^(Leafpad)$" },                              float = true, center = true })
hl.window_rule({ match = { class = "^(brave)$" },                                float = true })
hl.window_rule({ match = { title = "^(DevTools)$" },                             float = true })
hl.window_rule({ match = { class = "com.nextcloud.desktopclient.nextcloud" },     float = true })
hl.window_rule({ match = { class = "obsidian" },                                  focus_on_activate = true })

-- Workspace assignments
hl.window_rule({ match = { class = "^(brave-browser)$" },                        workspace = "1" })
hl.window_rule({ match = { class = "^(kitty)$" },                                workspace = "2" })
hl.window_rule({ match = { class = "^(code)$" },                                 workspace = "6" })
hl.window_rule({ match = { class = "^(obsidian)$" },                             workspace = "10" })
hl.window_rule({ match = { title = "^(Chat)$" },                                 workspace = "4" })
hl.window_rule({ match = { title = "^(Claude)$" },                               workspace = "4" })
hl.window_rule({ match = { title = "^(NotebookLM)$" },                           workspace = "4" })
hl.window_rule({ match = { title = "^(Home Assistant)$" },                       workspace = "5" })

-- Todoist (float + size + position)
hl.window_rule({ match = { title = "^(Todoist)$" },    float = true, size = "1200 800", move = "500 300" })

-- Misc float rules
hl.window_rule({ match = { title = "^(LaTeX OCR)$" },                            float = true })
hl.window_rule({ match = { title = "^(Open Folder)$" },                          float = true })
hl.window_rule({ match = { title = "^(bluetooth)$" },                            float = true })
hl.window_rule({ match = { class = "^(brave-nngceckbapebfimnlniiiahkandclblb-Default)" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.ksnip.ksnip)" },                       float = true })
hl.window_rule({ match = { class = "^(qalculate-gtk)" },                         float = true })
hl.window_rule({ match = { class = "^(handy)$" },                                float = true })

-- Zotero
hl.window_rule({
    name  = "zotero-plugins",
    match = { class = "Zotero", title = "^(Plugins Manager)" },
    float = true,
})
hl.window_rule({ match = { class = "^(t|T)hunar" },                              float = true })
hl.window_rule({ match = { class = "^(vlc)" },                                   float = true })
hl.window_rule({ match = { class = "^(feh)" },                                   float = true, center = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)" },                float = true })
hl.window_rule({ match = { class = "^(Matplotlib)" },                            float = true, center = true })
hl.window_rule({ match = { title = "^(Zotero Settings)" },                       float = true })
hl.window_rule({ match = { class = "^(Zotero)$" },                               confine_pointer = true })
hl.window_rule({ match = { title = "^(Bluetooth)" },                             float = true })

-- Suppress maximize requests from all apps
hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Gromit-mpx (screen annotation overlay)
hl.window_rule({
    match     = { class = "^(Gromit-mpx)$" },
    no_blur   = true,
    opacity   = 1.0,
    no_shadow = true,
    size      = "100% 100%",
})

-- Layer rules
hl.layer_rule({ match = { namespace = "swaync-control-center" },       blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" },  blur = true, ignore_alpha = 0.5 })
