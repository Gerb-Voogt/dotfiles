#!/usr/bin/python3
# Prompt 1:
# - Select a course
# Prompt 2:
# - Select an operation
#   - Open a Note
#   - Compile last note
#   - Compile last 2 notes
#   - Compile all notes
import sys
import os
import subprocess
import yaml
import re
from dataclasses import dataclass
from rofi import rofi

MAIN_COURSES_DIR = '/home/gerb/uni/courses'
NOTES_DIR = '/home/gerb/uni/Vault-MSc'
FILES_DIR = '/home/gerb/uni/courses'

@dataclass
class Course:
    title: str
    short: str
    code: str
    url: str
    year: str
    quarter: str
    active: bool

    def find_notes_dir(self, root: str = NOTES_DIR) -> str | None:
        for dirpath, _, _ in os.walk(root):
            if self.code in dirpath:
                return dirpath
        return None

    def find_files_dir(self, root: str = FILES_DIR) -> str:
        # It's safe to write the function like this as the 
        # courses are defined by the .yaml file in the course
        # directory. Hence the folder always must exists
        # or else it would not be defined as a course in the first place
        return_value = ''
        for dirpath, _, _ in os.walk(root):
            if self.code in dirpath.split('/')[-1]:
                return_value = dirpath
        return return_value


class Color:
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    DARKCYAN = '\033[36m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'


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


def main():
    courses = scan_folders_for_yaml_file()

    match_group = re.compile("AM[0-9]+[-_][0-9]+.md")
    names = []

    # This matches 
    input = "AM1010"
    for course in courses:
       if course.code == input:
           for _, _, filenames in os.walk(course.find_notes_dir()):
               for file in filenames:
                   name = match_group.match(file)
                   if name is not None:
                       names.append(name.group())


if __name__ == "__main__":
    main()
    
