#!/bin/bash
# Migration script to restructure dotfiles for modular GNU Stow usage
# This converts from "stow ." structure to package-per-app structure

set -e  # Exit on error

echo "Starting dotfiles migration to modular structure..."
echo "This will reorganize your ~/.dots directory for per-package stowing"
echo ""

# Backup first (optional but recommended)
read -p "Create backup first? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    BACKUP_DIR="$HOME/.dots-backup-$(date +%Y%m%d-%H%M%S)"
    echo "Creating backup at $BACKUP_DIR..."
    cp -r ~/.dots "$BACKUP_DIR"
    echo "Backup created!"
fi

cd ~/.dots

echo ""
echo "Creating package directories..."

# Migrate each .config subdirectory to its own package
for dir in .config/*/; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        echo "  Creating package: $dirname"
        mkdir -p "$dirname/.config"
        mv "$dir" "$dirname/.config/"
    fi
done

# Handle .config files (not directories)
if ls .config/* 2>/dev/null | grep -v '/$' >/dev/null; then
    echo "  Creating package: config-files (for loose config files)"
    mkdir -p config-files/.config
    for file in .config/*; do
        if [ -f "$file" ]; then
            mv "$file" config-files/.config/
        fi
    done
fi

# Remove empty .config directory
if [ -d .config ] && [ -z "$(ls -A .config)" ]; then
    rmdir .config
    echo "  Removed empty .config directory"
fi

# Migrate bin/ to scripts package
if [ -d bin ]; then
    echo "  Creating package: scripts"
    mkdir -p scripts
    mv bin scripts/
fi

# Migrate .local/ to local package
if [ -d .local ]; then
    echo "  Creating package: local"
    mkdir -p local
    mv .local local/
fi

# Migrate .zshrc to zsh package
if [ -f .zshrc ]; then
    echo "  Creating package: zsh"
    mkdir -p zsh
    mv .zshrc zsh/
fi

# Migrate .gemini/ to gemini package
if [ -d .gemini ]; then
    echo "  Creating package: gemini"
    mkdir -p gemini
    mv .gemini gemini/
fi

echo ""
echo "Migration complete!"
echo ""
echo "Your new structure:"
ls -1 | grep -v -E "^\." | grep -v "README.md" | grep -v ".packages.txt" | grep -v "migrate-to-modular.sh" | grep -v "install.sh" | grep -v "uninstall.sh"

echo ""
echo "To install all packages, run:"
echo "  cd ~/.dots && stow */"
echo ""
echo "To install specific packages only:"
echo "  cd ~/.dots && stow hypr kitty nvim"
echo ""
echo "An install.sh script has been created for convenience."
