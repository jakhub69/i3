#!/usr/bin/env bash

set -euo pipefail

echo "==> Konfiguracja usług"

SERVICES=(
dbus
NetworkManager
bluetoothd
)

for svc in "${SERVICES[@]}"; do

    if [ -d "/etc/sv/$svc" ]; then

        if [ ! -L "/var/service/$svc" ]; then

            echo "Włączanie $svc"

            ln -s "/etc/sv/$svc" "/var/service/$svc"

        else

            echo "$svc już działa."

        fi

    fi

done

echo

echo "==> Restart usług"

sv restart dbus || true
sv restart NetworkManager || true
sv restart bluetoothd || true

echo

echo "Usługi gotowe."