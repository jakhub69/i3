#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$USER_NAME")

echo "==> PipeWire"

PACKAGES=(
pipewire
wireplumber
alsa-pipewire
libspa-bluetooth
pavucontrol
playerctl
)

for pkg in "${PACKAGES[@]}"; do

    if ! xbps-query "$pkg" >/dev/null 2>&1; then
        xbps-install -y "$pkg"
    fi

done

echo
echo "==> Tworzenie katalogów"

mkdir -p "$USER_HOME/.config/pipewire"

echo
echo "==> ALSA"

mkdir -p /etc/alsa/conf.d

cat >/etc/alsa/conf.d/50-pipewire.conf <<EOF
pcm.!default {
    type pipewire
}

ctl.!default {
    type pipewire
}
EOF

echo
echo "==> Bluetooth"

if [ ! -L /var/service/bluetoothd ]; then
    ln -sf /etc/sv/bluetoothd /var/service/
fi

echo
echo "==> WirePlumber"

mkdir -p "$USER_HOME/.config/wireplumber"

echo
echo "==> Test"

if command -v wpctl >/dev/null; then

    echo
    wpctl status || true

fi

echo
echo "PipeWire skonfigurowany."