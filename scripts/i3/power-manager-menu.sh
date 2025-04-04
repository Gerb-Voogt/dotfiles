#!/usr/bin/env bash

selection=$(echo "Reboot Shutdown Logout Sleep" | tr ' ' '\n' | rofi -dmenu)

if [[ "$selection" == "Reboot" ]]; then
    shutdown -r now
elif [[ "$selection" == "Shutdown" ]]; then
    shutdown -h now
elif [[ "$selection" == "Logout" ]]; then
    i3-msg exit
elif [[ "$selection" == "Sleep" ]]; then
    echo "Sleeping!"
fi
