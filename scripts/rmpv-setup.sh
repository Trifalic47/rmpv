# #!/bin/bash
# set -euo pipefail
#
# echo "== rmpv setup =="
#
# CONFIG_DIR="$HOME/.config"
# SHARE_DIR="/usr/share/rmpv/dots"
#
# # ── copy dotfiles ──────────────────────────────────────
# echo "[+] Installing configs..."
# rm -rf "$CONFIG_DIR/mpv"
# rm -rf "$CONFIG_DIR/rmpc"
# cp -r "$SHARE_DIR/mpv"  "$CONFIG_DIR/mpv"
# cp -r "$SHARE_DIR/rmpc" "$CONFIG_DIR/rmpc"
# echo "[+] mpv  → $CONFIG_DIR/mpv"
# echo "[+] rmpc → $CONFIG_DIR/rmpc"
#
# # ── user config ────────────────────────────────────────
# read -rp "Music directory (default ~/Music): " MUSIC_DIR
# MUSIC_DIR="${MUSIC_DIR:-$HOME/Music}"
#
# read -rp "MPD socket (default ~/.config/mpd/socket): " MPD_SOCKET
# MPD_SOCKET="${MPD_SOCKET:-$HOME/.config/mpd/socket}"
#
# mkdir -p "$HOME/.config/rmpv"
# cat > "$HOME/.config/rmpv/config" <<EOF
# MUSIC_DIR=$MUSIC_DIR
# MPD_SOCKET=$MPD_SOCKET
# EOF
#
# echo "[✓] Config saved → $HOME/.config/rmpv/config"
# echo ""
# echo "Done! Run: rmpv open"

#!/bin/bash

# Define where the system stored the templates
TEMPLATE_DIR="/usr/share/rmpv/dots"

echo "[+] Setting up configurations..."

# Create user config dir if it doesn't exist
mkdir -p "$HOME/.config"

# Copy from the GLOBAL directory to the USER directory
if [ -d "$TEMPLATE_DIR" ]; then
    cp -r "$TEMPLATE_DIR/mpd"  "$HOME/.config/"
    cp -r "$TEMPLATE_DIR/mpv"  "$HOME/.config/"
    cp -r "$TEMPLATE_DIR/rmpc" "$HOME/.config/"
    echo "[✓] Dotfiles copied to ~/.config/"
else
    echo "[!] Error: Templates not found in $TEMPLATE_DIR"
    exit 1
fi

# Run the rest of your MPD logic (mkdir playlists, etc.)
mkdir -p "$HOME/.config/mpd/playlists"
touch "$HOME/.config/mpd/database"

echo "[✓] Setup complete. You can now run 'rmpv open'"
