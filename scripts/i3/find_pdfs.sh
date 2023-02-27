#!/bin/bash

pdf_files=$(find /home/gerb/uni -name "*.pdf")
selected_file=$(echo "$pdf_files" | rofi -dmenu -p "Select PDF file")

if [ "$selected_file" != "" ]; then
    zathura "$selected_file" &
fi

