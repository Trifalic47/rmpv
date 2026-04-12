#!/bin/bash
set -euo pipefail

echo "== rmpv installer =="

# ─────────────────────────────
# repo root
# ─────────────────────────────
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[i] Repo: $REPO"

# ─────────────────────────────
# detect real user (IMPORTANT FIX)
# ─────────────────────────────
if [[ -n "${SUDO_USER:-}" ]]; then
    USER_HOME="$(eval echo "~$SUDO_USER")"
else
    USER_HOME="$HOME"
fi

CONFIG_DIR="$USER_HOME/.config"

echo "[i] User home: $USER_HOME"

# ─────────────────────────────
# dependencies check
# ─────────────────────────────
for cmd in mpv yt-dlp mpc rmpc; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "[!] Missing dependency: $cmd"
        exit 1
    fi
done

# ─────────────────────────────
# user input
# ─────────────────────────────
read -rp "Music directory (default ~/Music): " MUSIC_DIR
MUSIC_DIR="${MUSIC_DIR:-$USER_HOME/Music}"

read -rp "MPD socket (default ~/.config/mpd/socket): " MPD_SOCKET
MPD_SOCKET="${MPD_SOCKET:-$USER_HOME/.config/mpd/socket}"

# ─────────────────────────────
# save config
# ─────────────────────────────
mkdir -p "$USER_HOME/.config/rmpv"

cat > "$USER_HOME/.config/rmpv/config" <<EOF
MUSIC_DIR=$MUSIC_DIR
MPD_SOCKET=$MPD_SOCKET
EOF

echo "[+] Config saved at $USER_HOME/.config/rmpv/config"

# ─────────────────────────────
# install binaries (root required only here)
# ─────────────────────────────
echo "[+] Installing binaries..."

sudo install -Dm755 "$REPO/bin/rmpv" /usr/local/bin/rmpv
sudo install -Dm755 "$REPO/bin/rmpv-play" /usr/local/bin/rmpv-play
sudo install -Dm755 "$REPO/bin/rmpv-search" /usr/local/bin/rmpv-search

# ─────────────────────────────
# install dotfiles (USER MODE FIX)
# ─────────────────────────────
echo "[+] Installing configs..."

mkdir -p "$CONFIG_DIR"

# clean old configs (prevents merge bugs)
rm -rf "$CONFIG_DIR/mpv"
rm -rf "$CONFIG_DIR/rmpc"

cp -r "$REPO/dots/mpv"  "$CONFIG_DIR/mpv"
cp -r "$REPO/dots/rmpc" "$CONFIG_DIR/rmpc"

echo "[+] mpv config → $CONFIG_DIR/mpv"
echo "[+] rmpc config → $CONFIG_DIR/rmpc"

# ─────────────────────────────
# done
# ─────────────────────────────
echo ""
echo "[✓] Installation complete"
echo ""
echo "Run:"
echo "  rmpv open"
echo "  rmpv play <url/file>"
echo "  rmpv search <query>"
