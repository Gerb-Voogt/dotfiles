#!/usr/bin/python3
import os
import sys
import yaml
import getch
import subprocess
from dataclasses import dataclass

# Global Variable, change later to pull these from a config file
MAIN_COURSES_DIR = '/home/gerb/uni/courses'
NOTES_DIR = '/home/gerb/uni/Vault'
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
    

# Could wrap up this and cd_notes_folder into a generic open
# some specified path in tmux window function
def cd_files_folder(course: Course | None):
    if course is not None:
        files_dir = course.find_files_dir()
        subprocess.run(['tmux', 'new-window', '-c', files_dir])


def cd_notes_folder(course: Course | None):
    if course is not None:
        notes_dir = course.find_notes_dir()
        if notes_dir is not None:
            subprocess.run(['tmux', 'new-window', '-c', notes_dir])
        else:
            print('Notes directory not found...')


def open_url(course: Course):
    if course.url == '':
        print('Brightspace url not found...')
    else:
        subprocess.run(['firefox', f'{course.url}'])


def find_course() -> Course | None:
    cur_dir = os.getcwd()
    os.chdir(MAIN_COURSES_DIR)
    find_dirs_command = 'find . -maxdepth 2 -type d -print'
    directories = subprocess.Popen(find_dirs_command.split(' '), stdout=subprocess.PIPE)
    course_location = subprocess.check_output(['fzf'], stdin=directories.stdout)
    course_location_decoded = course_location.decode().replace('.', MAIN_COURSES_DIR).strip('\n') + '/'
    course = create_course_object_from_yaml_file(course_location_decoded)
    os.chdir(cur_dir)
    return course
    

def prompt_menu_1_courses(courses: list[Course]) -> Course | None:
    # Initializing variables
    selection = 0
    color = ''
    exit_var = False
    find_var = False
    courses_to_prompt = list(filter(lambda course: course.active == True, courses))
    
    for index, course in enumerate(courses_to_prompt):
        # Extract course code
        course_code_prefix = course.code[0:2]

        # Set color based on faculty of the course
        match course_code_prefix:
            case 'WB' | 'ME':
                color = Color.YELLOW
            case 'AM' | 'TW' | 'WI':
                color = Color.PURPLE
            case 'SC':
                color = Color.BLUE
            case _:
                color = ''

        print(color + f'{index + 1}. {course.code} {course.title}' + Color.END)

    print('Press q to exit')
    print('Press f to find a deactivated course')

    while True:
        try:
            selection = getch.getch()
            if selection == 'q':
                print('Exiting...')
                exit_var = True
            elif selection == 'f':
                find_var = True
            else:
                selection = int(selection)
            break
        except:
            pass

    # Exiting directly from the loop somehow did not work for some
    # reason so this variable thing is here instead
    # Likely a bug due to threading but I don't feel like trying to fix
    # that right now
    if exit_var:
        sys.exit()
    elif find_var:
        course = find_course()
    else:
        course = courses_to_prompt[selection - 1]

    return course


def prompt_menu_2_courses(course: Course):
    selection= 0
    exit_var = False

    print('Select operation:')
    print('1. cd Files (new tmux window)')
    print('2. cd Notes (new tmux window)')
    print('3. Open Brightspace')

    print('Press q to exit')

    while True:
        try:
            selection = getch.getch()
            if selection == 'q':
                print('Exiting...')
                exit_var = True
            else:
                selection = int(selection)
            break
        except:
            pass

    # Same as the menu 1 case
    if exit_var == True:
        sys.exit(1)

    match selection:
        case 1:
            cd_files_folder(course)
        case 2:
            cd_notes_folder(course)
        case 3:
            open_url(course)


def main():
    courses = scan_folders_for_yaml_file()
    print('Select a number:')
    course = prompt_menu_1_courses(courses)
    if course is not None:
        prompt_menu_2_courses(course)
    else:
        print('info.yaml not found')

if __name__ == '__main__':
    main()
