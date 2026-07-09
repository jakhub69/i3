#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$USER_NAME")

echo "==> Kopiowanie dotfiles"

mkdir -p "$USER_HOME/.config"
mkdir -p "$USER_HOME/.local/bin"
mkdir -p "$USER_HOME/Pictures"

cp -a .config/. "$USER_HOME/.config/"

if [ -d wallpapers ]; then
    mkdir -p "$USER_HOME/Pictures/Wallpapers"
    cp -a wallpapers/. "$USER_HOME/Pictures/Wallpapers/"
    cp -a wallpapers/. "$USER_HOME/wallpapers"
fi

if [ -d shell ]; then
    mkdir -p "$USER_HOME/.local/bin"

    find shell -type f -exec cp {} "$USER_HOME/.local/bin/" \;

    chmod +x "$USER_HOME"/.local/bin/*
fi

echo
echo "==> Naprawianie ścieżek"

find "$USER_HOME/.config" -type f -exec \
sed -i "s|/home/jakub|$USER_HOME|g" {} \;

echo
echo "==> Uprawnienia"

chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.local"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/Pictures"

echo "Dotfiles skopiowane."