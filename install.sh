#!/bin/bash
# Install all dotfiles packages using GNU Stow

set -e

cd ~/.dots

echo "Installing dotfiles with GNU Stow..."
echo ""

# Get all package directories (exclude dotfiles and regular files)
packages=$(ls -1 | grep -v -E "^\." | grep -v "README.md" | grep -v ".packages.txt" | grep -v -E "\\.sh$")

if [ -z "$packages" ]; then
    echo "No packages found. Have you run migrate-to-modular.sh?"
    exit 1
fi

# Stow each package
for package in $packages; do
    if [ -d "$package" ]; then
        echo "  Stowing: $package"
        stow -v "$package"
    fi
done

echo ""
echo "All dotfiles installed successfully!"
echo ""
echo "To uninstall, run: ./uninstall.sh"
