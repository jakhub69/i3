#!/bin/bash

# Wymuszenie standardowego formatowania danych (niezależnie od języka systemu)
export LC_ALL=C

# Pobieranie danych
RAM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
DISK=$(df -h / | awk 'NR==2 {print $3 "/" $2}')

# Niezawodne pobranie zużycia procesora z /proc/stat
CPU=$(awk '{u=$2+$4; d=$2+$4+$5; if(NR==1){u1=u; d1=d;}else{print int((u-u1)/(d-d1)*100)}}' <(grep 'cpu ' /proc/stat) <(sleep 0.1; grep 'cpu ' /proc/stat))

# Dane z Twojego RTX 4070
GPU=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

# Wysłanie powiadomienia do Dunsta
notify-send -t 5000 "System Usage" "RAM: $RAM\nDisk: $DISK\nCPU: $CPU%\nGPU: $GPU% | Temp: ${TEMP}°C"