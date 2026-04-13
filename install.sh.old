#!/bin/bash
set -euo pipefail

echo "== rmpv installer =="

REPO="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
USER_HOME="$HOME"

echo "[i] Repo: $REPO"

# ─────────────────────────────
# SYSTEM DEPENDENCIES
# ─────────────────────────────
echo "[+] Installing dependencies..."

sudo pacman -S --needed --noconfirm \
    mpd mpv rofi yt-dlp mpc rmpc

# optional
sudo pacman -S --needed wildmidi timidity++ >/dev/null 2>&1 || true

# ─────────────────────────────
# STOP OLD MPD (IMPORTANT)
# ─────────────────────────────
echo "[+] Stopping old MPD..."

pkill -9 mpd >/dev/null 2>&1 || true
systemctl --user stop mpd >/dev/null 2>&1 || true
systemctl --user stop mpd.socket >/dev/null 2>&1 || true

# ─────────────────────────────
# CREATE MPD DIRECTORY STRUCTURE
# ─────────────────────────────
echo "[+] Setting up MPD directories..."

mkdir -p "$USER_HOME/.config/mpd"
mkdir -p "$USER_HOME/.config/mpd/playlists"
mkdir -p "$USER_HOME/.local/share/mpd"
mkdir -p "$USER_HOME/.cache/mpd"

touch "$USER_HOME/.local/share/mpd/database"

# ─────────────────────────────
# GENERATE MPD CONFIG (FULL AUTO FIXED)
# ─────────────────────────────
echo "[+] Writing MPD config..."

cat > "$USER_HOME/.config/mpd/mpd.conf" <<EOF
music_directory     "$USER_HOME/Music"

db_file             "$USER_HOME/.local/share/mpd/database"
playlist_directory  "$USER_HOME/.config/mpd/playlists"
log_file            "$USER_HOME/.local/share/mpd/log"
pid_file            "$USER_HOME/.local/share/mpd/pid"
state_file          "$USER_HOME/.local/share/mpd/state"

auto_update         "yes"
auto_update_depth   "3"

bind_to_address     "127.0.0.1"
port                "6600"

audio_output {
    type "pipewire"
    name "PipeWire"
}

restore_paused "yes"
EOF

# ─────────────────────────────
# INSTALL YOUR BINARIES
# ─────────────────────────────
echo "[+] Installing rmpv tools..."

sudo install -Dm755 "$REPO/bin/rmpv" /usr/local/bin/rmpv
sudo install -Dm755 "$REPO/bin/rmpv-play" /usr/local/bin/rmpv-play
sudo install -Dm755 "$REPO/bin/rmpv-search" /usr/local/bin/rmpv-search

# ─────────────────────────────
# START MPD WITH CORRECT CONFIG
# ─────────────────────────────
echo "[+] Starting MPD..."

mpd --no-daemon --config "$USER_HOME/.config/mpd/mpd.conf" >/dev/null 2>&1 &

sleep 2

# ensure running
if ! pgrep mpd >/dev/null; then
    echo "[!] MPD failed to start"
    exit 1
fi

echo "[✓] MPD running"

mpc update >/dev/null 2>&1 || true

# ─────────────────────────────
# FINAL CHECK
# ─────────────────────────────
echo "[+] Verifying installation..."

for cmd in mpd mpv rofi yt-dlp mpc rmpc; do
    command -v "$cmd" >/dev/null || {
        echo "[!] Missing: $cmd"
        exit 1
    }
done

echo ""
echo "[✓] rmpv installation complete"
echo ""
echo "Run:"
echo "  rmpv open"
echo "  rmpc"
echo "  rmpv play <url>"
