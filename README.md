
# rmpv 🎵📺

A lightweight terminal-based music + video controller using **mpv + yt-dlp + mpc + rmpc**
Built for fast media playback, YouTube streaming, and CLI control.

---

## ⚡ Preview

### UI Preview 1

![preview1](images/preview1.png)

### UI Preview 2

![preview2](images/preview2.png)

### UI Preview 3

![preview3](images/preview3.png)

---

## 🚀 Features

* 🎧 Play local music instantly
* 📺 Stream YouTube videos via mpv
* 🔍 Search and play from CLI
* 🎛️ Control playback using rmpc
* 💾 Save configs automatically
* ⚡ Minimal + fast setup

---

## 📦 Dependencies

Make sure these are installed before running:

### Core

* `mpv` → media player
* `yt-dlp` → YouTube/media extractor
* `mpc` → MPD client control
* `rmpc` → CLI controller (required for UI/control layer)

---

### Install dependencies (Arch Linux)

```bash
sudo pacman -S mpv yt-dlp mpc mpd
```

### Install rmpc

```bash
cargo install rmpc
```

---

## 🛠️ Installation

### 1. Clone the repo

```bash
git clone git@github.com:Trifalic47/rmpv.git
cd rmpv
```

OR

```bash
git clone https://github.com/Trifalic47/rmpv.git
cd rmpv
```

---

### 2. Run installer

```bash
bash install.sh
```

---

## 🎮 Usage

### Open player

```bash
rmpv open
```

### Play media

```bash
rmpv play <url or file>
```

### Search YouTube

```bash
rmpv search "song name"
```

---

## 📁 Project Structure

```
rmpv/
├── bin/                # CLI binaries
├── dots/              # mpv + rmpc configs
├── images/            # previews
├── scripts/           # setup scripts
├── install.sh        # installer
└── README.md
```

---

## ⚙️ Config Location

After installation:

```
~/.config/rmpv/config
```

Example:

```
MUSIC_DIR=~/Music
MPD_SOCKET=~/.config/mpd/socket
```

---

## 🧠 Requirements Notes

* MPD must be running if using rmpc features
* yt-dlp required for YouTube playback
* mpv must support youtube-dl backend (yt-dlp)

---

## 🧪 Troubleshooting

### mpv slow YouTube loading

Make sure yt-dlp is installed:

```bash
yt-dlp --version
```

### rmpc not responding

Ensure MPD is running:

```bash
mpd --no-daemon
```

---

# Install songs
[Google Drive - Music](https://drive.google.com/drive/folders/19Yjdsd1q0D70O4Ye-Bi3FNZEF0IJCz4q?usp=drive_link)
[Google Drive - Video](https://drive.google.com/drive/folders/11GDfocqTXpVkRuWPMZt4K6jz_NsIeCkh?usp=drive_link)

### Keybinds

---

## 👨‍💻 Author

* GitHub: [@Trifalic47](https://github.com/Trifalic47)

Repo:
[https://github.com/Trifalic](https://github.com/Trifalic47/rmpv)
