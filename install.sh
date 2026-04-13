#!/bin/bash
set -euo pipefail

echo "== rmpv installer =="

REPO="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
USER_HOME="$HOME"

echo "[i] Repo: $REPO"

# ─────────────────────────────
# DEPENDENCIES
# ─────────────────────────────
echo "[+] Installing dependencies..."

sudo pacman -S --needed --noconfirm \
    mpd mpv rofi yt-dlp mpc rmpc

sudo pacman -S --needed wildmidi timidity++ >/dev/null 2>&1 || true

# ─────────────────────────────
# STOP OLD SERVICES
# ─────────────────────────────
echo "[+] Stopping old MPD..."

pkill -9 mpd >/dev/null 2>&1 || true
systemctl --user stop mpd >/dev/null 2>&1 || true
systemctl --user stop mpd.socket >/dev/null 2>&1 || true

# ─────────────────────────────
# INSTALL DOTFILES (IMPORTANT FIX)
# ─────────────────────────────
echo "[+] Installing dotfiles..."

mkdir -p "$USER_HOME/.config"

rm -rf "$USER_HOME/.config/mpd"
rm -rf "$USER_HOME/.config/mpv"
rm -rf "$USER_HOME/.config/rmpc"

cp -r "$REPO/dots/mpd"  "$USER_HOME/.config/mpd"
cp -r "$REPO/dots/mpv"  "$USER_HOME/.config/mpv"
cp -r "$REPO/dots/rmpc" "$USER_HOME/.config/rmpc"

# ─────────────────────────────
# MPD DIRECTORIES (NO MANUAL DATABASE FILE)
# ─────────────────────────────
echo "[+] Setting up MPD runtime..."

mkdir -p "$USER_HOME/.local/share/mpd"
mkdir -p "$USER_HOME/.cache/mpd"
mkdir -p "$USER_HOME/.config/mpd/playlists"

# IMPORTANT: DO NOT create database manually
# MPD will generate it itself

# ─────────────────────────────
# INSTALL BINARIES
# ─────────────────────────────
echo "[+] Installing binaries..."

sudo install -Dm755 "$REPO/bin/rmpv" /usr/local/bin/rmpv
sudo install -Dm755 "$REPO/bin/rmpv-play" /usr/local/bin/rmpv-play
sudo install -Dm755 "$REPO/bin/rmpv-search" /usr/local/bin/rmpv-search

# ─────────────────────────────
# START MPD
# ─────────────────────────────
echo "[+] Starting MPD..."

mpd "$USER_HOME/.config/mpd/mpd.conf" >/dev/null 2>&1 &

sleep 2

if ! pgrep mpd >/dev/null; then
    echo "[!] MPD failed to start"
    exit 1
fi

echo "[✓] MPD running"

mpc update >/dev/null 2>&1 || true

echo ""
echo "[✓] rmpv installed successfully"
echo ""
echo "Run:"
echo "  rmpv open"
echo "  rmpc"
echo "  rmpv play <url>"
