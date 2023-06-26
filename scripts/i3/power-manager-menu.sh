#!/usr/bin/env bash

selection=$(echo "Reboot Shutdown Sleep" | tr ' ' '\n' | rofi -dmenu)

if [[ "$selection" == "Reboot" ]]; then
    shutdown -r now
elif [[ "$selection" == "Shutdown" ]]; then
    shutdown -h now
elif [[ "$selection" == "Sleep" ]]; then
    echo "Sleeping!"
fi
