#!/bin/bash

pdf_files=$(/home/gerb/i3-scripts/find_pdfs)
pdf_names=$(/home/gerb/i3-scripts/find_pdfs | /home/gerb/i3-scripts/filename.py)

# Use Rofi to select a PDF file by name
selected_name=$(echo "${pdf_names[@]}" | rofi -dmenu -i -p " Select file")

# Get the full path of the selected file
selected_file=$(echo "$pdf_files" | grep -F -m 1 "$selected_name")

if [ -n "$selected_name" ]; then
    zathura "$selected_file" &
fi


