#!/bin/bash

# 1. Function to check and install rmpc

# Smarter helper check
AUR_HELPER=$(command -v yay || command -v paru)
if [ -z "$AUR_HELPER" ]; then
    echo "[!] No AUR helper (yay/paru) found. Please install rmpc manually."
else
    $AUR_HELPER -S rmpc
fi

check_rmpc() {
    if ! command -v rmpc &> /dev/null; then
        echo "[!] rmpc is not installed."
        read -p "[?] Would you like to install rmpc now using yay? (y/N): " choice
        case "$choice" in
          y|Y )
            echo "[+] Installing rmpc..."
            yay -S rmpc --noconfirm || echo "[!] Failed to install rmpc. Please install it manually."
            ;;
          * )
            echo "[i] Skipping rmpc installation. Some features may not work."
            ;;
        esac
    else
        echo "[✓] rmpc is already installed."
    fi
}

# 2. Main Setup Logic
echo "== rmpv Setup Helper =="

# Run the dependency check
check_rmpc

# 3. Rest of your config copying logic
TEMPLATE_DIR="/usr/share/rmpv/dots"
echo "[+] Copying configurations..."

mkdir -p "$HOME/.config"
cp -r "$TEMPLATE_DIR/mpd"  "$HOME/.config/"
cp -r "$TEMPLATE_DIR/mpv"  "$HOME/.config/"
cp -r "$TEMPLATE_DIR/rmpc" "$HOME/.config/"

# 4. MPD Runtime Setup
mkdir -p "$HOME/.config/mpd/playlists"
# ... rest of your script ...
