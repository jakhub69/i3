#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$USER_NAME")

echo "==> Konfiguracja środowiska dla gier"

###############################################################################
# Instalacja pakietów
###############################################################################

PACKAGES=(
steam
gamemode
mesa-demos
)

for pkg in "${PACKAGES[@]}"; do

    if ! xbps-query "$pkg" >/dev/null 2>&1; then
        xbps-install -y "$pkg"
    fi

done

###############################################################################
# MangoHud
###############################################################################

mkdir -p "$USER_HOME/.config/MangoHud"

cat > "$USER_HOME/.config/MangoHud/MangoHud.conf" <<EOF
fps
frame_timing
gpu_stats
gpu_temp
gpu_core_clock
gpu_mem_clock
gpu_power
gpu_fan
cpu_stats
cpu_temp
ram
vram
io_read
io_write
engine_version
vulkan_driver
position=top-left
toggle_hud=F12
EOF

###############################################################################
# GameMode
###############################################################################

mkdir -p /etc

cat >/etc/gamemode.ini <<EOF
[general]
renice=10
softrealtime=auto

[gpu]
apply_gpu_optimisations=accept-responsibility
EOF

###############################################################################
# NVIDIA
###############################################################################

mkdir -p "$USER_HOME/.config/environment.d"

cat > "$USER_HOME/.config/environment.d/99-nvidia.conf" <<EOF
__GL_SHADER_DISK_CACHE=1
__GL_SHADER_DISK_CACHE_PATH=$USER_HOME/.cache/nvidia
__GL_THREADED_OPTIMIZATIONS=1
EOF

mkdir -p "$USER_HOME/.cache/nvidia"

###############################################################################
# Steam Launch Options
###############################################################################

mkdir -p "$USER_HOME/.local/share/jakhub"

cat > "$USER_HOME/.local/share/jakhub/steam-launch-options.txt" <<EOF
gamemoderun mangohud %command%
EOF

###############################################################################
# CS2
###############################################################################

cat > "$USER_HOME/.local/share/jakhub/cs2-launch-options.txt" <<EOF
gamemoderun mangohud -novid -high %command%
EOF

###############################################################################
# Test Vulkan
###############################################################################

echo
echo "==> Vulkan"

if command -v vulkaninfo >/dev/null; then

    vulkaninfo >/dev/null 2>&1 && echo "Vulkan OK"

fi

###############################################################################
# NVIDIA
###############################################################################

if command -v nvidia-smi >/dev/null; then

    echo
    nvidia-smi

fi

###############################################################################
# Uprawnienia
###############################################################################

chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.config"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.cache"
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.local"

echo
echo "==========================================="
echo "Gaming został skonfigurowany."
echo
echo "Steam Launch Options:"
echo "gamemoderun mangohud %command%"
echo
echo "CS2 Launch Options:"
echo "gamemoderun mangohud -novid -high %command%"
echo "==========================================="