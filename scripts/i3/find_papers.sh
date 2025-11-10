#!/bin/bash

# Get list of pdf files (one per line)
mapfile -t pdf_files < <(/home/gerben/uni/dotfiles/scripts/i3/find_papers)
mapfile -t pdf_names < <(/home/gerben/uni/dotfiles/scripts/i3/find_papers | /home/gerben/uni/dotfiles/scripts/i3/filename.py)

# Use rofi to select by name
selected_name=$(printf "%s\n" "${pdf_names[@]}" | rofi -dmenu -i -p " Papers")

# Get index of selected name
for i in "${!pdf_names[@]}"; do
    if [[ "${pdf_names[$i]}" == "$selected_name" ]]; then
        selected_file="${pdf_files[$i]}"
        break
    fi
done

# Open with zathura if selection not empty
if [[ -n "$selected_file" ]]; then
    nohup zathura "$selected_file" >/dev/null 2>&1 &
fi

