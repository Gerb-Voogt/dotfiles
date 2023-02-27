#!/bin/zsh

pdf_files=$(/home/gerb/i3-scripts/find_pdfs)
pdf_names=$(/home/gerb/i3-scripts/find_pdfs | /home/gerb/i3-scripts/filename.py)

#
# Use Rofi to select a PDF file by name
selected_name=$(echo "${pdf_names[@]}" | rofi -dmenu -i -p "Select PDF file")

# Get the full path of the selected file
selected_file=$(echo "$pdf_files" | grep -F "$selected_name")

zathura "$selected_file" &

