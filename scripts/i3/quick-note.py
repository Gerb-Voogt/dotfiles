#!/usr/bin/python3
import os
import subprocess
import datetime
from rofi import rofi


NOTES_DIR = os.getenv("NOTES_DIR", "/home/gerben/uni/Vault-MSc")
HOME = os.getenv("HOME");
EDITOR = os.getenv("EDITOR");
NOTE_TEMPLATE = "---\ndocumentclass: article\nclassoption: twocolumn\n---\n\n# Title\n..."


def quick_note():
    """ Create a quick note which is placed in the inbox to sort out manually later """
    # This should be the very first option in the menu.
    # Ctrl + Alt + N -> Enter should immediately bring up an environment to type stuff in
    inbox_folder = f"{NOTES_DIR}/inbox"
    list_of_notes = os.listdir(inbox_folder)
    index, note = rofi("Select Note", list_of_notes)

    if index == -1 and note == "":
        exit()

    if note not in list_of_notes :
        note = format_note_file_name(note)
        create_note(inbox_folder, note)
    open_note_in_editor(inbox_folder, note)


# [NOTE]: This function is not single responsibility and violates the clean coding principles
#   regardless, this is just a small script used for QOL changes and is only pushed to my dotfiles
#   repo for easy access when using a new machine so I don't think I intend to refactor this at any point.
def project_note():
    """
    @description Create a quick note which is placed in a specific project under $NOTES_DIR/projects/{project_id}.
        If the specified project does not yet exist, it is automatically created. After project note name is prompted,
        which opens the note if it exists or creates it if it does not.
    """
    list_of_projects = os.listdir(f"{NOTES_DIR}/projects/")
    index, proj = rofi(" Select Project", list_of_projects)

    # Exit is none selected
    if index == -1 and proj == "":
        exit()

    # Create the project directory if it does not yet exist
    if proj not in list_of_projects:
        try:
            os.mkdir(f"{NOTES_DIR}/projects/{proj}")
        except FileExistsError:
            pass # discard the error if the directory already exists even though this should never happen

    path = f"{NOTES_DIR}/projects/{proj}"
    list_of_notes = os.listdir(path)
    index, note = rofi("note_name", list_of_notes)

    # Exit is none selected
    if index == -1 and note == "":
        exit()

    if note not in list_of_notes :
        note = format_note_file_name(note)
        create_note(path, note)
        
    open_note_in_editor(path, note)


def open_note_in_editor(note_path: str, note_filename: str):
    subprocess.run(["tmux-sessionizer", f"{note_path}"])
    folder_name = note_path.split("/")[-1]
    cmd = ["tmux", "send-keys", "-t", f"{folder_name}:1.1", "nvim", " +'set wrap'", f" {note_filename}", "Enter"]
    subprocess.run(cmd)


def open_note_in_editor_with_pdf(note_path: str, note_filename: str):
    subprocess.run(["tmux-sessionizer", f"{note_path}"])
    folder_name = note_path.split("/")[-1]
    cmd = ["tmux", "send-keys", "-t", f"{folder_name}:1.1", "note", " -d", f" {note_filename}", "Enter"]
    subprocess.run(cmd)


def course_note():
    """ Create a quick note which is placed in a specific course notes folder in $NOTES_DIR/{course_code_prefix}/{course_code} """
    # Same as project note, more structured
    raise Exception(f"[ERROR]: Unimplemented function: {__name__}")
    

def format_note_file_name(filename: str) -> str:
    """ Formats the note file name with proper .md file extension """
    if filename.endswith(".md"):
        return filename
    else:
        return f"{filename}.md"


def create_note(note_path: str, note_name: str):
    with open(f"{note_path}/{note_name}", "w") as fd:
        fd.write(NOTE_TEMPLATE)


def open_note(note_path: str, note_name: str):
    note_name_pdf = note_name.replace("md", "pdf")
    command = f"zathura {note_path}/{note_name_pdf}"
    subprocess.run(command.split(), start_new_session=True)


def main() -> int:
    categories = ["quick notes", "project notes", "course notes"]
    index, selected = rofi("Select Category", categories)

    if index == -1 and selected == "":
        exit()

    match (selected):
        case "quick notes":
            quick_note()
        case "project notes":
            project_note()
        case "course notes":
            course_note()

    return 0


if __name__ == "__main__":
    main()
