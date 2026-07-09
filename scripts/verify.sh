#!/usr/bin/env bash

set -e

GREEN="\033[1;32m"
RED="\033[1;31m"
RESET="\033[0m"

ok() {

echo -e "${GREEN}[ OK ]${RESET} $1"

}

fail() {

echo -e "${RED}[FAIL]${RESET} $1"

}

echo

echo "=========================="
echo " WERYFIKACJA SYSTEMU"
echo "=========================="

echo

############################
# NVIDIA
############################

if command -v nvidia-smi >/dev/null; then

ok "Sterownik NVIDIA"

else

fail "Brak sterownika NVIDIA"

fi

############################
# Vulkan
############################

if command -v vulkaninfo >/dev/null; then

ok "Vulkan"

else

fail "Brak Vulkan"

fi

############################
# PipeWire
############################

if command -v wpctl >/dev/null; then

ok "PipeWire"

else

fail "PipeWire"

fi

############################
# i3
############################

if command -v i3 >/dev/null; then

ok "i3"

else

fail "i3"

fi

############################
# Picom
############################

if command -v picom >/dev/null; then

ok "Picom"

else

fail "Picom"

fi

############################
# Rofi
############################

if command -v rofi >/dev/null; then

ok "Rofi"

else

fail "Rofi"

fi

############################
# Alacritty
############################

if command -v alacritty >/dev/null; then

ok "Alacritty"

else

fail "Alacritty"

fi

############################
# Steam
############################

if command -v steam >/dev/null; then

ok "Steam"

else

fail "Steam"

fi

############################
# MangoHud
############################

if command -v mangohud >/dev/null; then

ok "MangoHud"

else

fail "MangoHud"

fi

############################
# GameMode
############################

if command -v gamemoderun >/dev/null; then

ok "GameMode"

else

fail "GameMode"

fi

echo

echo "Gotowe."

echo