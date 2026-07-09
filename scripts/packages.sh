#!/usr/bin/env bash

set -euo pipefail

echo "==> Aktualizacja repozytoriów"

xbps-install -Sy

###############################################################################
# Repo nonfree
###############################################################################

if [ ! -f /etc/xbps.d/00-repository-nonfree.conf ]; then
    echo "==> Instalacja repozytorium nonfree"
    xbps-install -y void-repo-nonfree
    xbps-install -Sy
fi

###############################################################################
# Pakiety podstawowe
###############################################################################

BASE_PACKAGES=(
git
curl
wget
unzip
zip
tar
bash-completion

htop
btop
fastfetch

xorg
xinit
xrandr
xset
xrdb

mesa-demos
mesa-vulkan-intel
vulkan-loader
Vulkan-Tools
mesa-dri
mesa-vaapi

dbus

NetworkManager

i3
i3status

picom
rofi
dunst
feh
alacritty

pcmanfm

maim
xclip
xsel

firefox

polkit
polkit-elogind

pipewire
wireplumber
alsa-pipewire
pavucontrol
playerctl

gamemode
MangoHud

steam

python3
python3-pip

font-awesome6
noto-fonts-ttf
noto-fonts-emoji

xdg-user-dirs
xdg-utils

brightnessctl

jq
tree
ripgrep

elogind
)

###############################################################################
# Bluetooth
###############################################################################

BT_PACKAGES=(
bluez
bluez-alsa
)

###############################################################################
# Instalacja
###############################################################################

echo
echo "==> Instalacja pakietów"

for pkg in "${BASE_PACKAGES[@]}"; do

    if xbps-query "$pkg" >/dev/null 2>&1; then
        printf "  [OK] %s\n" "$pkg"
    else
        printf "  [INSTALL] %s\n" "$pkg"
        xbps-install -y "$pkg"
    fi

done

###############################################################################
# Bluetooth
###############################################################################

echo
echo "==> Bluetooth"

for pkg in "${BT_PACKAGES[@]}"; do

    if xbps-query "$pkg" >/dev/null 2>&1; then
        printf "  [OK] %s\n" "$pkg"
    else
        xbps-install -y "$pkg"
    fi

done

###############################################################################
# Katalogi użytkownika
###############################################################################

USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")

sudo -u "${SUDO_USER:-$USER}" xdg-user-dirs-update

mkdir -p "$USER_HOME/.config"
mkdir -p "$USER_HOME/.local/bin"
mkdir -p "$USER_HOME/.local/share/fonts"
mkdir -p "$USER_HOME/Pictures"
mkdir -p "$USER_HOME/Downloads"

###############################################################################
# Testy
###############################################################################

echo
echo "==> Wersje"

echo "XBPS : $(xbps-install --version | head -n1)"
echo "Kernel: $(uname -r)"

echo
echo "Pakiety zakończone."