#!/usr/bin/bash

working_dir=$(pwd)
template_type="default"

while getopts "dht:" opt; do
	case $opt in
		d) # Supress deletion of combine md file
			delete_pdf=1
			;;
		h) # Print help
			echo "Note: Note writing script for nvim"
			echo "Flags:"
			echo "-h: Prints the help menu"
			echo "-d: Delete the generated pdf file"
			echo "-t: Use alternative header template (defualt or paper)"
			exit 0;
			;;
		t) # template file selection
			template_type=$OPTARG
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
tmux_running=$(pgrep tmux)

if [[ ! -z $tmux_running ]]; then
	tmux rename-window "Note"
fi

if [[ ! -f "$working_dir/$1" && "$template_type" == "default" ]]; then
	echo "File $1 does not exist"
	touch $1
	echo "---" >> $1
	echo "documentclass: article" >> $1
	echo "classoption: twocolumn" >> $1
	echo "---" >> $1
	echo "" >> $1
	echo "# Title" >> $1
	echo "..." >> $1
elif [[ ! -f $working_dir/$1 && "$template_type" == "paper" ]]; then
	cat /home/gerben/uni/templates/markdown-pdf/template.md >> $1
fi

notec -H $template_type $1
zathura "$working_dir/$note_pdf_name" &
nvim -c "set wrap" -c "set spell" -c "autocmd BufWritePost $1 !notec $1" $1

zathura_process=$(pgrep "$note_pdf_name")
if [[ -z $zathura_process ]]; then
	pkill -f "$note_pdf_name"
fi

if [[ $delete_pdf -eq 1 ]]; then
	rm $note_pdf_name
fi

if [[ ! -z $tmux_running ]]; then
	tmux rename-window "zsh"
fi
