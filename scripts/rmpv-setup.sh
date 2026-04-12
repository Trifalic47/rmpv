#!/bin/bash
set -euo pipefail

echo "== rmpv setup =="

CONFIG_DIR="$HOME/.config"
SHARE_DIR="/usr/share/rmpv/dots"

# Copy dotfiles
echo "[+] Installing configs..."
rm -rf "$CONFIG_DIR/mpv"
rm -rf "$CONFIG_DIR/rmpc"
cp -r "$SHARE_DIR/mpv"  "$CONFIG_DIR/mpv"
cp -r "$SHARE_DIR/rmpc" "$CONFIG_DIR/rmpc"
echo "[+] mpv  → $CONFIG_DIR/mpv"
echo "[+] rmpc → $CONFIG_DIR/rmpc"

# Ask for user config
read -rp "Music directory (default ~/Music): " MUSIC_DIR
MUSIC_DIR="${MUSIC_DIR:-$HOME/Music}"

read -rp "MPD socket (default ~/.config/mpd/socket): " MPD_SOCKET
MPD_SOCKET="${MPD_SOCKET:-$HOME/.config/mpd/socket}"

mkdir -p "$HOME/.config/rmpv"
cat > "$HOME/.config/rmpv/config" <<CONF
MUSIC_DIR=$MUSIC_DIR
MPD_SOCKET=$MPD_SOCKET
CONF

echo "[✓] Config saved → $HOME/.config/rmpv/config"
echo ""
echo "Done! Run: rmpv open"
