#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$SCRIPT_DIR"

if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

source scripts/utils.sh

banner
check_void

bash scripts/packages.sh
bash scripts/nvidia.sh
bash scripts/audio.sh
bash scripts/services.sh
bash scripts/fonts.sh
bash scripts/dotfiles.sh
bash scripts/monitors.sh
bash scripts/gaming.sh
bash scripts/verify.sh

green "Instalacja zakończona."

echo
echo "Uruchom ponownie komputer."