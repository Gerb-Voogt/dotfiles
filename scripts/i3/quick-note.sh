#!/usr/bin/bash

OPTIONS="add todo"
SELECTED=`echo -e "$OPTIONS" | rofi -dmenu`

WEEK_NUM=`date +%-V`
YEAR_NUM=`date +%-Y`
NOTE_NAME="$YEAR_NUM-week-$WEEK_NUM.md"
NOTES_FOLDER="/home/gerben/uni/Thesis-vault/general-notes"

if [ "$SELECTED" = "add todo" ]; then
    alacritty --class floatingterm -e nvim -n +12 "$NOTES_FOLDER/$NOTE_NAME"
fi
