#!/usr/bin/bash

working_dir=$(pwd)
output_file_name="output.pdf"
author="Gerb"
document_title=0
generate_toc=0
document_date=0

while getopts "a:t:o:m:hdc" opt; do
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
		m) # Add date details to compilation
			document_date=$OPTARG
			;;
		a) # Add author and title details to compilation
			author=$OPTARG
			;;
		c) # Generate a Document TOC
			generate_toc="true"
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
	echo "-m: Sets the document date"
	echo "-c: Setting this flag will result in a TOC being geenrated for the document"
	echo "-o: Sets the name of the output pdf file"
	echo "-d: Supress deletion of merged md file"
	exit 0;
fi


if [[ $document_title != 0 ]]; then
	echo "\\title{$document_title}" >> main.md
	echo "\\author{$author}" >> main.md

	if [[ $document_date != 0 ]]; then
		echo "$document_date" >> main.md
	else
		echo "\\date{Compilation Date: \\today}" >> main.md
	fi

	echo "\\maketitle" >> main.md
fi

if [[ $generate_toc != 0 ]]; then
	echo "\\tableofcontents" >> main.md
	echo "\\newpage" >> main.md
fi

shift $((OPTIND - 1))


if [[ $# -gt 0 ]]; then
	if [[ $# -eq 1 ]]; then
		output_file_name=${@/md/pdf}
	fi
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

bibliography_file=$(ls | grep "\.bib")
echo "$bibliography_file"
csl_path="/home/gerb/uni/dotfiles/templates/IEEE.csl"

if [[ -f "./$bibliography_file" ]]; then
	echo "adding bibliography!"
	if [[ "$bibliography_file" =~ " " ]]; then
		echo "Mutliple bibliography files found, multiple .bib files is currently not supported."
		exit 1;
	else
		# Add the bibliography if it is present
		mdpp main.md
		pandoc --citeproc --bibliography "./$bibliography_file" --csl $csl_path main.md.p -H ~/uni/templates/markdown-pdf/header.tex -o $output_file_name
	fi
else # Bib file is not present
	mdpp main.md
	pandoc --citeproc main.md.p -H ~/uni/templates/markdown-pdf/header.tex -o $output_file_name
fi

if [[ -z $delete_main_md ]]; then
	rm main.md main.md.p
fi
