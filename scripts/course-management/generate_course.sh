#!/usr/bin/bash

while getopts "hn" opt; do
	case $opt in
		n) # Supress deletion of combine md file
			supress_notes_folder=1
			;;
		h) # Print help
			echo "Generate new courses with the corresponding correct file structure"
			echo "Flags:"
			echo "-h: Prints the help menu"
			echo "-n: Suppress the creation of a notes folder"
			exit 0;
			;;
		\?)
			echo "Invalid flag: $OPTARG"
	esac
done

shift $((OPTIND - 1))

if [[ $# -gt 0 ]]; then
	echo "Error: Too many arguments; Usage: generate_course"
	exit 1
fi

COURSES_DIR="/home/gerb/uni/courses"
NOTES_DIR="/home/gerb/uni/Vault-MSc"

read -p "Code: " cc
read -p "Title (long): " title
read -p "Title (short): " title_short
read -p "Quarter: " quarter
read -p "Academic Year: " academic_year
read -p "Credits:" creds

course_yaml="title: '$title'
short: '$title_short'
code: '$cc'
url: ''
year: '$academic_year'
quarter: '$quarter'
credits: $creds
active: true"

dirname="$cc-$title_short"
codeprefix=$(echo "$cc" | grep -o "^[A-Z]*")

# Check if the course code base dir exists, create it if not
if [ -d "/home/gerb/uni/courses/$codeprefix" ]; then
	echo "Directory exists"
else
	mkdir /home/gerb/uni/courses/$codeprefix
fi
if [ -d "/home/gerb/uni/Vault-MSc/$codeprefix" ]; then
	echo "Directory exists"
else
	mkdir /home/gerb/uni/Vault-MSc/$codeprefix
fi


# Check if the files dir exists, if not create it
if [ -d "$COURSES_DIR/$codeprefix/$cc-$title_short" ]; then
	echo "Directory exists"
else
	mkdir "$COURSES_DIR/$codeprefix/$cc-$title_short"
	touch "$COURSES_DIR/$codeprefix/$cc-$title_short/info.yaml"
	echo "$course_yaml" > "$COURSES_DIR/$codeprefix/$cc-$title_short/info.yaml"
fi

# Check if suppression of notes folder is turned on or not
if [[ $supress_notes_folder -eq 1 ]]; then
	echo "Skipping creating notes folder!"
else
	# Check if the files dir exists, if not create it
	if [ -d "$NOTES_DIR/$codeprefix/$cc-$title_short" ]; then
		echo "Directory exists"
	else
		mkdir "$NOTES_DIR/$codeprefix/$cc-$title_short"
		mkdir "$NOTES_DIR/$codeprefix/$cc-$title_short/images"
		mkdir "$NOTES_DIR/$codeprefix/$cc-$title_short/slides"
	fi
fi
