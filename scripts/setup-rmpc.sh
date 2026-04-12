#!/bin/bash

echo "[+] Setting up rmpc config..."

mkdir -p "$HOME/.config/rmpc"

cp -r ../dotfiles/rmpc/* "$HOME/.config/rmpc/"

echo "[+] rmpc config installed"
