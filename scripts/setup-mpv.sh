#!/bin/bash

echo "[+] Setting up mpv config..."

mkdir -p "$HOME/.config/mpv"

cp -r ../dotfiles/mpv/* "$HOME/.config/mpv/"

echo "[+] mpv config installed"
