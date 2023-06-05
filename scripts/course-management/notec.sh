#!/usr/bin/bash

working_dir=$(pwd)
output_file_name="output.pdf"
author="Gerb"
document_title=0

while getopts "a:t:o:hd" opt; do
	case $opt in
		o) # Rename output file
			output_file_name=$OPTARG
			;;
		d) # Supress deletion of combine md file
			delete_main_md="false"
			;;
		t) # Add title details to compilation
			document_title=$OPTARG
			;;
		a) # Add author and title details to compilation
			author=$OPTARG
			;;
		h) # Print help
			print_help="true"
			;;
		\?)
			echo "Invalid flag: $OPTARG"
	esac
done

if [[ ! -z $print_help ]]; then
	echo "notec: Note-Compiler"
	echo "Flags:"
	echo "-h: Prints the help menu"
	echo "-a: Sets the document author (not printed if title is not set)"
	echo "-t: Sets the document title"
	echo "-o: Sets the name of the output pdf file"
	echo "-d: Supress deletion of merged md file"
	exit 0;
fi

if [[ $document_title != 0 ]]; then
	echo "\\title{$document_title}" >> main.md
	echo "\\author{$author}" >> main.md
	echo "\\date{\\today}" >> main.md
	echo "\\maketitle" >> main.md
fi

shift $((OPTIND - 1))


if [[ $# -gt 0 ]]; then
	# Check whether the files listed exists, if not raise an error
	# if yes combine them all to a big output file and pre-process that with 
	# mdpp and compile to pdf using pandoc
	for arg in "$@"; do
		echo $arg
		if [[ ! -e $arg ]]; then
			echo "Error: file $arg does not exist"
			exit 1;
		fi
		if [[ $arg != *.md ]]; then
			echo "Error: file $arg is not a markdown file"
			exit 1;
		fi
		cat $working_dir/$arg >> main.md
		echo "\\newpage" >> main.md
		echo "" >> main.md
	done
fi

mdpp main.md
pandoc main.md.p -H ~/uni/templates/markdown-pdf/header.tex -o $output_file_name
rm main.md.p

if [[ -z $delete_main_md ]]; then
	rm main.md
fi
