
INPUT="$*"

MPD_SOCKET="${MPD_SOCKET:-$HOME/.config/mpd/socket}"

# 1. Try extract URL
URL=$(echo "$INPUT" | grep -oE 'https?://[^ ]+' | head -n1)

if [[ -n "$URL" ]]; then
    exec nohup mpv \
        --no-terminal \
        --force-window=yes \
        --ytdl-format="bestvideo[height<=720][vcodec!=av01]+bestaudio/best[height<=720]" \
        --cache=yes \
        --cache-secs=2 \
        --demuxer-readahead-secs=2 \
        --hwdec=auto-safe \
        "$URL" >/dev/null 2>&1 &    exit 0
fi
# 2. Ask MPD for current song path (IMPORTANT PART)
FILE=$(mpc --host="$MPD_SOCKET" current -f "%file%")

# fallback if empty
if [[ -z "$FILE" ]]; then
    FILE="$INPUT"
fi

# 3. Convert MPD file path → real filesystem path
MUSIC_DIR="$HOME/Music"
FULL_PATH="$MUSIC_DIR/$FILE"

# 4. play local file
if [[ -f "$FULL_PATH" ]]; then
    exec nohup mpv "$FULL_PATH" >/dev/null 2>&1 &
    exit 0
fi

# 5. fallback last resort
exec nohup mpv "$INPUT" >/dev/null 2>&1 &
