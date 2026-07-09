#!/usr/bin/env bash

set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$USER_NAME")

CONFIG="$USER_HOME/.config/i3/config"

if [ ! -f "$CONFIG" ]; then
    echo "Nie znaleziono konfiguracji i3."
    exit 0
fi

echo "==> Wykrywanie monitorów"

MONITORS=($(xrandr --query | awk '/ connected/{print $1}'))

COUNT=${#MONITORS[@]}

echo "Znaleziono $COUNT monitor(y)"

for m in "${MONITORS[@]}"; do
    echo " - $m"
done

###############################################################################
# Zamiana nazw monitorów
###############################################################################

if [ "$COUNT" -ge 1 ]; then

    sed -i "s/DP-0/${MONITORS[0]}/g" "$CONFIG"
    sed -i "s/HDMI-0/${MONITORS[0]}/g" "$CONFIG"

fi

if [ "$COUNT" -ge 2 ]; then

    sed -i "s/DP-2/${MONITORS[1]}/g" "$CONFIG"

fi

###############################################################################
# Sprawdzenie programów z exec
###############################################################################

echo
echo "==> Sprawdzanie autostartu"

grep "exec" "$CONFIG" | while read -r line
do

    CMD=$(echo "$line" | sed 's/.*exec --no-startup-id //' | awk '{print $1}')

    CMD=$(basename "$CMD")

    if command -v "$CMD" >/dev/null 2>&1; then

        printf "  [OK] %s\n" "$CMD"

    else

        printf "  [BRAK] %s\n" "$CMD"

    fi

done

###############################################################################
# Automatyczny xrandr
###############################################################################

XRANDR="$USER_HOME/.local/bin/monitors.sh"

cat > "$XRANDR" <<EOF
#!/usr/bin/env bash

MONITORS=(\$(xrandr --query | awk '/ connected/{print \$1}'))

if [ \${#MONITORS[@]} -eq 1 ]; then

xrandr --output "\${MONITORS[0]}" --auto

elif [ \${#MONITORS[@]} -eq 2 ]; then

xrandr \
--output "\${MONITORS[0]}" --primary --auto \
--output "\${MONITORS[1]}" --right-of "\${MONITORS[0]}" --auto

elif [ \${#MONITORS[@]} -ge 3 ]; then

xrandr \
--output "\${MONITORS[0]}" --primary --auto \
--output "\${MONITORS[1]}" --right-of "\${MONITORS[0]}" --auto \
--output "\${MONITORS[2]}" --left-of "\${MONITORS[0]}" --auto

fi
EOF

chmod +x "$XRANDR"

###############################################################################
# Dodaj do i3
###############################################################################

if ! grep -q ".local/bin/monitors.sh" "$CONFIG"; then

echo "exec --no-startup-id ~/.local/bin/monitors.sh" >> "$CONFIG"

fi

echo
echo "Monitory skonfigurowane."