#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

green() {
    echo -e "${GREEN}$1${NC}"
}

red() {
    echo -e "${RED}$1${NC}"
}

yellow() {
    echo -e "${YELLOW}$1${NC}"
}

blue() {
    echo -e "${BLUE}$1${NC}"
}

banner() {

echo

echo "██╗ ██████╗ "
echo "██║██╔════╝ "
echo "██║███████╗ "
echo "██║╚════██║ "
echo "██║███████║ "
echo "╚═╝╚══════╝ "

echo

green "Void Linux i3 Installer"

echo

}

require_root() {

if [ "$EUID" -ne 0 ]; then
    red "Uruchom jako root."
    exit 1
fi

}

check_void() {

if ! command -v xbps-install >/dev/null; then
    red "To nie jest Void Linux."
    exit 1
fi

}