#!/usr/bin/python3
import sys
import os
import subprocess
import yaml
import re
from dataclasses import dataclass
from rofi import rofi
from tulok import Course, Color

MAIN_COURSES_DIR = '/home/gerb/uni/courses'
NOTES_DIR = '/home/gerb/uni/Vault-MSc'
FILES_DIR = '/home/gerb/uni/courses'


def read_yaml_file(path_to_file: str) -> dict | None:
    target_file = path_to_file + '/info.yaml'

    try:
        with open(target_file, 'r') as file_buffer:
            data = yaml.load(file_buffer, Loader = yaml.loader.SafeLoader)
            return data

    except FileNotFoundError:
        # print(f"info.yaml not found at {path_to_file}")
        pass



def create_course_object_from_yaml_file(path_to_course: str) -> Course | None:
    data = read_yaml_file(path_to_course)
    if data is not None:
        course = Course(
                data['title'],
                data['short'],
                data['code'],
                data['url'],
                data['year'],
                data['quarter'],
                data['active'],
                )
        return course
    else:
        return None


def scan_folders_for_yaml_file() -> list:
    course_objects = []
    course_code_prefix = os.listdir(MAIN_COURSES_DIR)
    for prefix in course_code_prefix:
        courses_dir = MAIN_COURSES_DIR + f'/{prefix}'
        courses = os.listdir(courses_dir)

        for course in courses:
            path_to_course = courses_dir + f'/{course}'
            course_data = create_course_object_from_yaml_file(path_to_course)
            if course_data is not None:
                course_objects.append(course_data)
    return course_objects


def compile_single_note(note_path: str, note_name: str):
    command = f"notec {note_name}"
    subprocess.run(command.split(), cwd=note_path)


def compile_multiple_notes(note_path: str, note_names: list, course: Course):
    note_numbers = []
    for note_name in note_names:
        note_numbers.append(note_name.split("-")[-1].split(".")[0])

    command = f"notec -o {course.code}-{note_numbers[0]}-{note_numbers[-1]}.pdf"
    for i in note_names:
        command += f" {i}"
    subprocess.run(command.split(), cwd=note_path)


def compile_all_notes(note_path: str, note_names: list, course: Course):
    title = f"{course.code}: {course.title} Lecture Notes {course.year}"
    pdf_name = f'{course.code}-notes.pdf' 
    command = ['notec', '-o', pdf_name, '-t', title, '-c', '-d']
    for i in note_names:
        command.append(i)
    subprocess.run(command, cwd=note_path)


def delete_notes(note_path, course: Course):
    match_group_1 = re.compile(course.code + "+[-_][0-9]+.pdf")
    match_group_2 = re.compile(course.code + "+[-_][0-9]+[-_][0-9]+.pdf")

    names = []
    for _, _, filenames in os.walk(note_path):
        for file in filenames:
            name_1 = match_group_1.match(file)
            if name_1 is not None:
                names.append(name_1.group())
            name_2 = match_group_2.match(file)
            if name_2 is not None:
                names.append(name_2.group())

    command = f"rm {course.code}-notes.pdf"
    for i in names:
        command += f" {i}"
    subprocess.run(command.split(), cwd=note_path)


def main():
    courses = scan_folders_for_yaml_file()

    courses_list = []
    for course in courses:
        if course.find_notes_dir() is not None:
            courses_list.append(f"{course.code}: {course.title}")

    _, selected_course = rofi("Select a Course", courses_list)

    if selected_course == "":
        sys.exit()

    course_code = selected_course.split(":")[0]
    match_group = re.compile(course_code + "+[-_][0-9]+.md")
    names = []

    for course in courses:
        if course.code == course_code:
            course_object = course

    note_path = course_object.find_notes_dir()
    for _, _, filenames in os.walk(note_path):
        for file in filenames:
            name = match_group.match(file)
            if name is not None:
                names.append(name.group())
    names.sort()

    _, selected = rofi("Compile Notes", ["Compile last note",
                                         "Compile last 2 notes",
                                         "Compile all notes",
                                         "Select specific note to compile",
                                         "Decompile all course notes"])

    match selected:
        case "Compile last note":
            note_name = names[-1]
            compile_single_note(note_path, note_name)

        case "Select specific note to compile":
            _, note_name = rofi("Select a Note", names)
            compile_single_note(note_path, note_name)

        case "Compile last 2 notes":
            if len(names) < 2:
                compile_single_note(note_path, names[0])
            else:
                note_names = names[-2:]
                compile_multiple_notes(note_path, note_names, course_object)

        case "Compile all notes":
            if len(names) < 2:
                compile_single_note(note_path, names[0])
            else:
                compile_all_notes(note_path, names, course_object)

        case "Decompile all course notes":
            delete_notes(note_path, course_object)

        case _:
            sys.exit()




if __name__ == "__main__":
    main()
    
