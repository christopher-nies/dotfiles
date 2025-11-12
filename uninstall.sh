#!/bin/bash
# Uninstall all dotfiles packages using GNU Stow

set -e

cd ~/.dots

echo "Uninstalling dotfiles with GNU Stow..."
echo ""

# Get all package directories (exclude dotfiles and regular files)
packages=$(ls -1 | grep -v -E "^\." | grep -v "README.md" | grep -v ".packages.txt" | grep -v -E "\\.sh$")

if [ -z "$packages" ]; then
    echo "No packages found."
    exit 1
fi

# Unstow each package
for package in $packages; do
    if [ -d "$package" ]; then
        echo "  Unstowing: $package"
        stow -D -v "$package"
    fi
done

echo ""
echo "All dotfiles uninstalled successfully!"
