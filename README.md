# My dotfiles

These are my dotfiles, managed with GNU Stow.

## Structure

Each directory is a stow package containing configs for a specific application:

```
~/.dots/
├── hypr/          - Hyprland window manager
├── kitty/         - Kitty terminal
├── nvim/          - Neovim editor
├── waybar/        - Waybar status bar
├── scripts/       - Custom bin scripts
├── zsh/           - Zsh shell config
└── ...
```

## Installation

### First Time Setup (Migration from old structure)

```bash
# If migrating from "stow ." structure:
cd ~/.dots
./migrate-to-modular.sh

# Then install all packages:
./install.sh
```

### Regular Usage

```bash
# Install all packages
cd ~/.dots && stow */

# Or use the convenience script
./install.sh

# Install specific packages only
cd ~/.dots
stow hypr kitty nvim waybar

# Remove a package
stow -D hypr

# Reinstall a package (useful after editing)
stow -R nvim
```

## Managing Packages

**Add new config:**
```bash
cd ~/.dots
mkdir -p myapp/.config
mv ~/.config/myapp myapp/.config/
stow myapp
```

**Update existing config:**
Just edit the files in ~/.dots/package-name/ - they're symlinked!

**Remove a package:**
```bash
stow -D package-name
```

## Uninstall

```bash
./uninstall.sh  # Removes all symlinks
```
