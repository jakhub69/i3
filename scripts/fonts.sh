#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$USER_NAME")

FONT_DIR="$USER_HOME/.local/share/fonts"

mkdir -p "$FONT_DIR"

echo "==> Instalacja GoMono Nerd Font"

if fc-list | grep -qi "GoMono Nerd Font"; then
    echo "GoMono Nerd Font jest już zainstalowany."
else

    TMP=$(mktemp -d)

    cd "$TMP"

    wget -q \
https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Go-Mono.zip \
-O Go-Mono.zip

    unzip -oq Go-Mono.zip

    cp *.ttf "$FONT_DIR/"

    rm -rf "$TMP"

fi

echo
echo "==> Odświeżanie cache"

fc-cache -fv

echo
echo "==> Sprawdzenie"

if fc-list | grep -qi "GoMono Nerd Font"; then

    echo "✓ Font zainstalowany"

else

    echo "✗ Font nie został znaleziony"

fi


echo
echo "Fonty gotowe."