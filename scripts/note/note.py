#!/usr/bin/python3
##########################################
# Usage:
# $note fileName.md
#	Open fileName.md as a note
# $note -n fileName.md or $note --name fileName.md
#	Initialise a new note with fileName
# $note -h or $note --help
#	Print help
##########################################
import subprocess
import argparse
import toml
import os
import sys


config = toml.load("/home/gerb/.config/note/config.toml")
# Global constants, I know this is bad practice but can be asked to do this properly
MAKEFILE_TEMPLATE_PATH = config["directories"]["makefile_template_path"]
MARKDOWN_TEMPLATE_PATH = config["directories"]["markdown_template_path"]
CURRENT_DIR = os.getcwd()


def read_file_data_to_list(file_path: str) -> list:
	with open(file_path, 'r') as file:	
		file_data_list = [line for line in file]
	return file_data_list


def generate_makefile(note_name: str) -> None:
	# Creating the makefile from the template
	note_file_name, note_file_extension = note_name.split(".")
	subprocess.run(["touch", "Makefile"])
	makefile_template_data = read_file_data_to_list(MAKEFILE_TEMPLATE_PATH)
	with open(CURRENT_DIR + "/Makefile", "w") as makefile:
		for line in makefile_template_data:
			makefile.write(line.replace("=template", "=" + note_file_name))


def create_new_note(note_name: str) -> None:
	print(f"Creating note: {note_name}")

	# Copy .md template
	subprocess.run(["cp", MARKDOWN_TEMPLATE_PATH, CURRENT_DIR + f"/{note_name}"])
	generate_makefile(note_name)


def open_note(note_name: str, delete_pdf = False) -> None:
	print(f"Opening note: {note_name}")
	if not os.path.isfile(CURRENT_DIR + f"/{note_name}"):
		raise Exception("File not found")

	note_file_name, note_file_extension = note_name.split(".")

	generate_makefile(note_name)
	subprocess.run(["make"])
	zathura_process = subprocess.Popen(["zathura", f"{note_file_name}.pdf"])

	# Launching neovim with correct setup
	launch_nvim_cmd = ["nvim",
			"-c",
			f"autocmd BufWritePost {note_name} make",
			"-c",
			f"autocmd VimLeave {note_name} !rm -f Makefile",
			note_name]
	subprocess.run(launch_nvim_cmd)

	# Deinit everything
	zathura_process.kill()
	if delete_pdf:
		subprocess.run(["rm", "-f", f"{note_file_name}.pdf"])


def parse_note_name(note_name: str) -> None:
	extension_split = note_name.split(".")
	try:
		if extension_split[1] != "md":
			print("File extesion should be .md!")
			sys.exit(1)
	except:
		print("Passed file does not have an extension!")
		sys.exit(1)


def main(note_name, delete):
	parse_note_name(note_name)
	if not os.path.isfile(CURRENT_DIR + f"/{note_name}"):
		create_new_note(note_name)
	open_note(note_name, delete)


if __name__ == "__main__":
	# Define options for cli arguments
	parser = argparse.ArgumentParser(
			prog = 'note',
			description = 'Note setup automation in Python')
	parser.add_argument('filename')
	parser.add_argument('-d', '--delete', action = 'store_true')
	args = parser.parse_args()
	print(args.filename, args.delete)

	main(args.filename, delete=args.delete)
