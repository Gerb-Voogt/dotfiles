#!/usr/bin/bash

working_dir=$(pwd)
delete_pdf=0

while getopts "dh" opt; do
	case $opt in
		d) # Supress deletion of combine md file
			delete_pdf=1
			;;
		h) # Print help
			echo "Note: Note writing script for nvim"
			echo "Flags:"
			echo "-h: Prints the help menu"
			echo "-d: Delete the generated pdf file"
			exit 0;
			;;
		\?)
			echo "Invalid flag: $OPTARG"
	esac
done


shift $((OPTIND - 1))

if [[ $# -gt 1 ]]; then
	echo "Error: To many arguments; Usage: note filename.md"
	exit 1
fi
if [[ $# -eq 0 ]]; then
	echo "Error: No note give; run note -h for help"
	exit 1
fi
if [[ $1 != *.md ]]; then
	echo "Error: file $1 is not a markdown file"
	exit 1
fi

note_pdf_name=${1/md/pdf}

if [[ ! -f $working_dir/$1 ]]; then
	echo "File $1 does not exist"
	touch $1
	echo "# Title" >> $1
	echo "..." >> $1
fi

notec $1
zathura "$working_dir/$note_pdf_name" &
nvim -c "autocmd BufWritePost $1 !notec $1" $1

pkill -f "$note_pdf_name"

if [[ $delete_pdf -eq 1 ]]; then
	rm $note_pdf_name
fi
