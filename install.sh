# #!/bin/bash
# set -e

# echo "== rmpv installer =="

# # ─────────────────────────────
# # detect repo root correctly
# # ─────────────────────────────
# REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# echo "[i] Repo: $REPO"

# # ─────────────────────────────
# # sudo only when needed
# # ─────────────────────────────
# if [[ $EUID -ne 0 ]]; then
#     echo "[i] Re-running with sudo..."
#     exec sudo bash "$0" "$@"
# fi

# # ─────────────────────────────
# # dependencies
# # ─────────────────────────────
# for cmd in mpv yt-dlp mpc rmpc; do
#     if ! command -v "$cmd" >/dev/null 2>&1; then
#         echo "[!] Missing dependency: $cmd"
#         exit 1
#     fi
# done

# # ─────────────────────────────
# # user config
# # ─────────────────────────────
# read -rp "Music directory (default ~/Music): " MUSIC_DIR
# MUSIC_DIR="${MUSIC_DIR:-$HOME/Music}"

# read -rp "MPD socket (default ~/.config/mpd/socket): " MPD_SOCKET
# MPD_SOCKET="${MPD_SOCKET:-$HOME/.config/mpd/socket}"

# # ─────────────────────────────
# # save config
# # ─────────────────────────────
# mkdir -p "$HOME/.config/rmpv"

# cat > "$HOME/.config/rmpv/config" <<EOF
# MUSIC_DIR=$MUSIC_DIR
# MPD_SOCKET=$MPD_SOCKET
# EOF

# echo "[+] Config saved"

# # ─────────────────────────────
# # install binaries
# # ─────────────────────────────
# echo "[+] Installing binaries..."

# install -Dm755 "$REPO/bin/rmpv" /usr/local/bin/rmpv
# install -Dm755 "$REPO/bin/rmpv-play" /usr/local/bin/rmpv-play
# install -Dm755 "$REPO/bin/rmpv-search" /usr/local/bin/rmpv-search

# # ─────────────────────────────
# # install dotfiles
# # ─────────────────────────────
# echo "[+] Installing configs..."

# mkdir -p "$HOME/.config"

# cp -r "$REPO/dots/mpv"  "$HOME/.config/mpv"
# cp -r "$REPO/dots/rmpc" "$HOME/.config/rmpc"

# echo "[+] Done"
# echo ""
# echo "Run:"
# echo "  rmpv open"
# echo "  rmpv play <url/file>"
# echo "  rmpv search <query>"

#!/usr/bin/env bash
set -e

echo "== rmpv installer =="

TMP_DIR=""

# ----------------------------
# detect if running via curl pipe
# ----------------------------
if [[ -f "$0" ]]; then
    REPO="$(cd "$(dirname "$0")" && pwd)"
else
    # curl | bash case
    TMP_DIR="$(mktemp -d)"
    git clone https://github.com/Trifalic47/rmpv.git "$TMP_DIR"
    REPO="$TMP_DIR"
fi

echo "[i] Repo: $REPO"

# ----------------------------
# deps
# ----------------------------
for cmd in mpv yt-dlp mpc rmpc; do
    command -v "$cmd" >/dev/null || {
        echo "[!] Missing dependency: $cmd"
        exit 1
    }
done

# ----------------------------
# config
# ----------------------------
read -rp "Music directory (default ~/Music): " MUSIC_DIR
MUSIC_DIR="${MUSIC_DIR:-$HOME/Music}"

read -rp "MPD socket (default ~/.config/mpd/socket): " MPD_SOCKET
MPD_SOCKET="${MPD_SOCKET:-$HOME/.config/mpd/socket}"

mkdir -p "$HOME/.config/rmpv"

cat > "$HOME/.config/rmpv/config" <<EOF
MUSIC_DIR=$MUSIC_DIR
MPD_SOCKET=$MPD_SOCKET
EOF

echo "[+] Config saved"

# ----------------------------
# install binaries
# ----------------------------
echo "[+] Installing binaries..."

sudo install -Dm755 "$REPO/bin/rmpv" /usr/local/bin/rmpv
sudo install -Dm755 "$REPO/bin/rmpv-play" /usr/local/bin/rmpv-play
sudo install -Dm755 "$REPO/bin/rmpv-search" /usr/local/bin/rmpv-search

# ----------------------------
# install dots
# ----------------------------
echo "[+] Installing dotfiles..."

mkdir -p "$HOME/.config/mpv"
mkdir -p "$HOME/.config/rmpc"

cp -r "$REPO/dots/mpv/." "$HOME/.config/mpv/"
cp -r "$REPO/dots/rmpc/." "$HOME/.config/rmpc/"

echo "[+] Done!"
echo "Run: rmpv open"
