#!/usr/bin/env bash

set -euo pipefail

echo "==> Sprawdzanie karty graficznej"

if ! lspci | grep -qi nvidia; then
    echo "Nie wykryto karty NVIDIA."
    exit 0
fi

echo "Karta NVIDIA wykryta."

###############################################################################
# Repo nonfree
###############################################################################

if [ ! -f /etc/xbps.d/00-repository-nonfree.conf ]; then
    xbps-install -y void-repo-nonfree
    xbps-install -Sy
fi

###############################################################################
# Sterowniki
###############################################################################

echo
echo "==> Instalacja sterownika"

xbps-install -y nvidia

###############################################################################
# Kernel module
###############################################################################

echo
echo "==> Aktualizacja initramfs"

if command -v xbps-reconfigure >/dev/null 2>&1; then
    xbps-reconfigure -fa
fi

###############################################################################
# NVIDIA DRM
###############################################################################

mkdir -p /etc/modprobe.d

cat >/etc/modprobe.d/nvidia.conf <<EOF
options nvidia-drm modeset=1
EOF

###############################################################################
# Test
###############################################################################

echo
echo "==> Test sterownika"

if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi || true
fi

###############################################################################
# Vulkan
###############################################################################

echo
echo "==> Vulkan"

if command -v vulkaninfo >/dev/null 2>&1; then
    vulkaninfo >/dev/null 2>&1 && echo "Vulkan OK" || echo "Vulkan jeszcze niedostępny (restart wymagany)"
fi

###############################################################################
# OpenGL
###############################################################################

if command -v glxinfo >/dev/null 2>&1; then
    echo
    glxinfo | grep "OpenGL renderer" || true
fi

###############################################################################
# X11
###############################################################################

mkdir -p /etc/X11/xorg.conf.d

cat >/etc/X11/xorg.conf.d/20-nvidia.conf <<EOF
Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
EndSection
EOF

echo
echo "Sterownik NVIDIA skonfigurowany."
echo "Po zakończeniu instalacji uruchom ponownie komputer."