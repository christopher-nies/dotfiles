#!/bin/bash
# Interactive package management for dotfiles

cd ~/.dots

show_menu() {
    echo ""
    echo "=== Dotfiles Package Manager ==="
    echo ""
    echo "1) List all packages"
    echo "2) Install a package"
    echo "3) Remove a package"
    echo "4) Reinstall a package"
    echo "5) Install all packages"
    echo "6) Remove all packages"
    echo "7) Show what's currently stowed"
    echo "q) Quit"
    echo ""
}

list_packages() {
    echo ""
    echo "Available packages:"
    ls -1 | grep -v -E "^\." | grep -v "README.md" | grep -v ".packages.txt" | grep -v -E "\\.sh$" | while read pkg; do
        if [ -d "$pkg" ]; then
            echo "  - $pkg"
        fi
    done
}

show_stowed() {
    echo ""
    echo "Currently stowed files (symlinks in ~/):"
    find ~ -maxdepth 3 -type l -lname "$HOME/.dots/*" 2>/dev/null | head -20
    echo ""
    echo "(showing first 20, there may be more...)"
}

while true; do
    show_menu
    read -p "Choose an option: " choice

    case $choice in
        1)
            list_packages
            ;;
        2)
            list_packages
            echo ""
            read -p "Enter package name to install: " pkg
            if [ -d "$pkg" ]; then
                stow -v "$pkg"
                echo "✓ $pkg installed"
            else
                echo "✗ Package '$pkg' not found"
            fi
            ;;
        3)
            list_packages
            echo ""
            read -p "Enter package name to remove: " pkg
            if [ -d "$pkg" ]; then
                stow -D -v "$pkg"
                echo "✓ $pkg removed"
            else
                echo "✗ Package '$pkg' not found"
            fi
            ;;
        4)
            list_packages
            echo ""
            read -p "Enter package name to reinstall: " pkg
            if [ -d "$pkg" ]; then
                stow -R -v "$pkg"
                echo "✓ $pkg reinstalled"
            else
                echo "✗ Package '$pkg' not found"
            fi
            ;;
        5)
            echo ""
            echo "Installing all packages..."
            ./install.sh
            ;;
        6)
            echo ""
            read -p "Remove ALL packages? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                ./uninstall.sh
            fi
            ;;
        7)
            show_stowed
            ;;
        q|Q)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done
