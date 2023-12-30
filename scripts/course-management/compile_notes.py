#!/usr/bin/python3.12
import sys
import os
import subprocess
import re
# import ruamel.yaml
from rofi import rofi
from tulok import Course, scan_folders_for_yaml_file

NOTES_DIR = '/home/gerb/uni/Vault-MSc'
FILES_DIR = '/home/gerb/uni/courses'
# 0 = No logging
# 1 = Debug Logging
LOG_LEVEL = 0


def log(string, LL=LOG_LEVEL):
    if LL == 1:
        print(string)


def compile_single_note(note_path: str, note_name: str) -> None:
    command = f"notec {note_name}"
    subprocess.run(command.split(), cwd=note_path)
    
def compile_single_note_and_open(note_path: str, note_name: str) -> None:
    compile_single_note(note_path, note_name)
    pdf_name = note_name.split(".")[0] + ".pdf"
    open_note(note_path, pdf_name)
    

def compile_multiple_notes(note_path: str, note_names: list, course: Course) -> None:
    note_numbers = []
    for note_name in note_names:
        note_numbers.append(note_name.split("-")[-1].split(".")[0])

    command = f"notec -o {course.code}-notes-{note_numbers[0]}-{note_numbers[-1]}.pdf"
    for i in note_names:
        command += f" {i}"
    subprocess.run(command.split(), cwd=note_path)

def compile_multiple_notes_and_open(note_path: str, note_names: list, course: Course) -> None:
    compile_multiple_notes(note_path, note_names, course)
    note_numbers = []
    for note_name in note_names:
        note_numbers.append(note_name.split("-")[-1].split(".")[0])
    pdf_name = f"{course.code}-notes-{note_numbers[0]}-{note_numbers[-1]}.pdf"
    open_note(note_path, pdf_name)


def compile_all_notes(note_path: str, note_names: list, course: Course) -> None:
    title = f"{course.code}: {course.title} Lecture Notes ({course.quarter}, {course.year})"
    pdf_name = f'{course.code}-notes-all.pdf' 
    command = ['notec', '-o', pdf_name, '-t', title, '-c']
    for i in note_names:
        command.append(i)
    subprocess.run(command, cwd=note_path)

def compile_all_notes_and_open(note_path: str, note_names: list, course: Course) -> None:
    compile_all_notes(note_path, note_names, course)
    pdf_name = f'{course.code}-notes-all.pdf' 
    open_note(note_path, pdf_name)


def delete_notes(note_path, course: Course) -> None:
    match_group_1 = re.compile(course.code + "-notes" + "+[-_][0-9]+.pdf")
    match_group_2 = re.compile(course.code + "-notes" + "+[-_][0-9]+[-_][0-9]+.pdf")

    names = []
    for _, _, filenames in os.walk(note_path):
        for file in filenames:
            name_1 = match_group_1.match(file)
            if name_1 is not None:
                names.append(name_1.group())
            name_2 = match_group_2.match(file)
            if name_2 is not None:
                names.append(name_2.group())

    command = f"rm {course.code}-notes-all.pdf"
    for i in names:
        command += f" {i}"
    subprocess.run(command.split(), cwd=note_path)


def open_note(note_path: str, note_name: str) -> None:
    note_name_pdf = note_name.replace("md", "pdf")
    command = f"zathura {note_path}/{note_name_pdf}"
    subprocess.run(command.split(), start_new_session=True)


def open_lecture_slides_or_pdf(course_path: str) -> None:
    print(course_path+"/slides")

    _, _, filenames = next(os.walk(course_path+'/slides'))
    filenames.sort()
    lecture_slides = [filename.replace("-", " ") for filename in filenames]

    _, selected = rofi(" Select a file", lecture_slides)

    if selected == "":
        sys.exit(0)

    selected = selected.replace(" ", "-")
    command = f"zathura {course_path}/slides/{selected}"
    subprocess.Popen(command.split(), start_new_session=True)


# def change_course_state(course: Course) -> None:
#     course_path = course.find_files_dir()
#     yaml = ruamel.yaml.YAML()
#     yaml.preserve_quotes = True
#
#     with open(course_path + "/info.yaml", "r") as fb:
#         data = yaml.load(fb)
#         data["active"] = not data["active"]
#     with open(course_path + "/info.yaml", "w") as fb:
#         yaml.dump(data, fb)


def main():
    courses = scan_folders_for_yaml_file()

    courses_list = []
    for course in courses:
        if course.find_notes_dir() is not None:
            courses_list.append(f"{course.code}: {course.title}")

    _, selected_course = rofi("  Select a Course", courses_list)

    if selected_course == "":
        sys.exit()

    course_code = selected_course.split(":")[0]
    match_group = re.compile(course_code + "-notes" + "+[-_][0-9]+.md")
    names = []
    course_object = None

    for course in courses:
        if course.code == course_code:
            course_object = course
    
    if course_object == None:
        sys.exit()

    note_path = course_object.find_notes_dir()
    for _, _, filenames in os.walk(note_path):
        for file in filenames:
            name = match_group.match(file)
            if name is not None:
                names.append(name.group())
    names.sort()

    _, selected = rofi("↳ Select Operation", [
        "Edit a note",
        "Open a note",
        "Open lecture slides or pdf",
        "Compile last note",
        "Compile last 2 notes",
        "Compile all notes",
        "Select specific note to compile",
        "Decompile all course notes",
        "Change course activity state",
        ])

    match selected:
        case "Compile last note":
            note_name = names[-1]
            compile_single_note_and_open(note_path, note_name)

        case "Compile last 2 notes":
            if len(names) < 2:
                compile_single_note_and_open(note_path, names[0])
            else:
                note_names = names[-2:]
                compile_multiple_notes_and_open(note_path, note_names, course_object)

        case "Compile all notes":
            if len(names) < 2:
                compile_single_note_and_open(note_path, names[0])
            else:
                compile_all_notes_and_open(note_path, names, course_object)

        case "Select specific note to compile":
            _, note_name = rofi("↳ Select a Note", names)
            compile_single_note(note_path, note_name)
            
        case "Open a note":
            prompt = names.copy()
            if len(names) > 1:
                prompt.append("Open master note")

            _, selection = rofi("↳ Select a Note", prompt)
            
            if selection == "Open master note":
                pdf_name = f'{course_object.code}-notes-all.pdf'
                if not os.path.isfile(note_path + "/" + pdf_name):
                    compile_all_notes(note_path, names, course_object)
                open_note(note_path, pdf_name)

            elif selection != "":
                pdf_name = selection.replace("md", "pdf")
                if not os.path.isfile(note_path + "/" + pdf_name):
                    compile_single_note(note_path, selection)
                open_note(note_path, pdf_name)

            else:
                sys.exit(0)

        case "Open lecture slides or pdf":
            open_lecture_slides_or_pdf(note_path)

        case "Edit a note": # This should probably be refactored in it's own function
            prompt = names.copy()
            prompt.append("Create next note")
            _, selection = rofi("↳ Select a Note", prompt)

            note_to_open = None
            if selection == "Create next note":
                if len(names) > 0:
                    split_last_note = names[-1].split("-")
                    number, _ = split_last_note[-1].split(".")
                    new_note_number = int(number) + 1
                    if new_note_number < 10:
                        note_to_open = f"{course_object.code}-notes-0{new_note_number}.md"
                    elif new_note_number >= 10:
                        note_to_open = f"{course_object.code}-notes-{new_note_number}.md"
                else: # if len(names) = 0, then no notes exist
                    note_to_open = f"{course_object.code}-notes-01.md"
            elif selection != "":
                note_to_open = selection
            else:
                sys.exit(0)

            if note_to_open is not None:
                subprocess.run(["tmux-sessionizer", f"{note_path}"])
                folder_name = note_path.split("/")[-1]
                log(folder_name)
                cmd = ["tmux", "send-keys", "-t", f"{folder_name}:1.1", "note", " -d", f" {note_to_open}", "Enter"]
                log(f"Running tmux command {cmd}")
                subprocess.run(["tmux",
                                "send-keys",
                                "-t",
                                f"{folder_name}:1.1",
                                "note",
                                " -d",
                                f" {note_to_open}",
                                "Enter"])

        case "Decompile all course notes":
            delete_notes(note_path, course_object)

        case "Change course activity state":
            change_course_state(course_object)

        case _:
            sys.exit()


if __name__ == "__main__":
    main()
    
