#!/usr/bin/python3
import os
import sys
import yaml
import getch
import re
import subprocess
from dataclasses import dataclass

# Global Variable, change later to pull these from a config file
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

    BLACK = "\u001b[30m"
    RED = "\u001b[31m"
    GREEN = "\u001b[32m"
    YELLOW = "\u001b[33m"
    BLUE = "\u001b[34m"
    PURPLE = "\u001b[35m"
    CYAN = "\u001b[36m"
    WHITE = "\u001b[37m"

    BRIGHT_BLACK = "\u001b[30;1m"
    BRIGHT_RED = "\u001b[31;1m"
    BRIGHT_GREEN = "\u001b[32;1m"
    BRIGHT_YELLOW = "\u001b[33;1m"
    BRIGHT_BLUE = "\u001b[34;1m"
    BRIGHT_PURPLE = "\u001b[35;1m"
    BRIGHT_CYAN = "\u001b[36;1m"
    BRIGHT_WHITE = "\u001b[37;1m"
    # PURPLE = '\033[95m'
    # CYAN = '\033[96m'
    # DARKCYAN = '\033[36m'
    # BLUE = '\033[94m'
    # GREEN = '\033[36m'
    # YELLOW = '\033[93m'
    # RED = '\033[91m'

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
def cd_files_folder(course: Course | None, tmux: bool = False):
    if course is not None:
        files_dir = course.find_files_dir()

        if tmux == False:
            # We do this dance with tmux panes to avoid the problem of not being
            # able to change the directory of the parent shell running the python program
            current_window_number = subprocess.check_output(['tmux', 'display-message', '-p', '#I'])\
                    .decode()\
                    .strip('\n')
            subprocess.run(['tmux', 'new-window', '-c', files_dir])
            new_window_number = subprocess.check_output(['tmux', 'display-message', '-p', '#I'])\
                    .decode()\
                    .strip('\n')
            subprocess.run(['tmux', 'swap-window', '-s', new_window_number, '-t', current_window_number])
            subprocess.run(['tmux', 'kill-pane'])
        else:
            subprocess.run(['tmux', 'new-window', '-c', files_dir])


def cd_notes_folder(course: Course | None, tmux: bool = False):
    if course is not None:
        notes_dir = course.find_notes_dir()
        if notes_dir is not None:
            if tmux == False:
                # We do this dance with tmux panes to avoid the problem of not being
                # able to change the directory of the parent shell running the python program
                current_window_number = subprocess.check_output(['tmux', 'display-message', '-p', '#I'])\
                        .decode()\
                        .strip('\n')
                subprocess.run(['tmux', 'new-window', '-c', notes_dir])
                new_window_number = subprocess.check_output(['tmux', 'display-message', '-p', '#I'])\
                        .decode()\
                        .strip('\n')
                subprocess.run(['tmux', 'swap-window', '-s', new_window_number, '-t', current_window_number])
                subprocess.run(['tmux', 'kill-pane'])
            else:
                subprocess.run(['tmux', 'new-window', '-c', notes_dir])


def open_course_url(course: Course):
    if course.url == '':
        print('Brightspace url not found...')
    else:
        subprocess.run(['firefox', f'{course.url}'])


def open_url(url: str):
    subprocess.run(['firefox', f'{url}'])


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
    other_uni_stuff_var = False

    courses_to_prompt = list(filter(lambda course: course.active == True, courses))
    
    for index, course in enumerate(courses_to_prompt):
        # Extract course code
        course_code_prefix = re.findall('[A-Z]+', course.code)[0]

        # Set color based on faculty of the course
        match course_code_prefix:
            case 'WB' | 'ME':
                color = Color.BRIGHT_YELLOW
            case 'AM' | 'TW' | 'WI':
                color = Color.BRIGHT_PURPLE
            case 'SC':
                color = Color.BRIGHT_BLUE
            case 'CSE' | 'TI' | 'CS':
                color = Color.BRIGHT_CYAN
            case 'CESE' | 'EE':
                color = Color.BRIGHT_RED
            case 'RO':
                color = Color.BRIGHT_GREEN
            case _:
                color = ''
        print(color + f'{index + 1}. {course.code} {course.title}' + Color.END)

    print('Press q to exit')
    print('Press f to find a deactivated course')
    print('Press h for other uni related links')

    while True:
        try:
            selection = getch.getch()
            if selection == 'q':
                print('Exiting...')
                exit_var = True
            elif selection == 'f':
                find_var = True
            elif selection == 'h':
                other_uni_stuff_var = True
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

    elif other_uni_stuff_var:
        prompt_menu_3_uni()

    else:
        course = courses_to_prompt[selection - 1]

    return course


def prompt_menu_2_courses(course: Course):
    selection= 0
    exit_var = False
    new_tmux_pane = False

    print('Select operation:')
    print('1. cd Files')
    print('2. cd Notes')
    print('3. Open Brightspace')

    print('Press q to exit')
    print('Press t to toggle tmux window properties')
    print(f'Open in new tmux window? {Color.RED}{new_tmux_pane}{Color.END} ', end='\r')

    while True:
        try:
            selection = getch.getch()
            if selection == 'q':
                print('\nExiting...')
                exit_var = True
                break
            if selection == 't':
                bool_color = Color.RED if new_tmux_pane == True else Color.GREEN
                new_tmux_pane = not new_tmux_pane
                print(f'Open in new tmux window? {bool_color}{new_tmux_pane}{Color.END} ', end='\r')
                continue
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
            cd_files_folder(course, tmux=new_tmux_pane)
        case 2:
            cd_notes_folder(course, tmux=new_tmux_pane)
        case 3:
            open_course_url(course)



def prompt_menu_3_uni():
    print('\033c', end='')
    selection= 0
    exit_var = False

    print('Select operation:')
    print('1. Open Webmail')
    print('2. Open MyTUDelft')
    print('3. Open Brightspace')
    print('4. Open TimeTable')

    print('Press q to exit')

    while True:
        try:
            selection = getch.getch()
            if selection == 'q':
                print('\nExiting...')
                exit_var = True
                break
            else:
                selection = int(selection)
            break
        except:
            pass

    # Same as the menu 1 case
    if exit_var == True:
        print('\033c', end='')
        sys.exit(1)

    match selection:
        case 1:
            open_url('https://webmail.tudelft.nl/')
        case 2:
            open_url('https://my.tudelft.nl/')
        case 3:
            open_url('https://brightspace.tudelft.nl/')
        case 4:
            open_url('https://mytimetable.tudelft.nl/schedule')
    print('\033c', end='')
    sys.exit()


def main():
    # Create an empty screen
    print('\033c', end='')

    courses = scan_folders_for_yaml_file()
    print('Select a number:')
    course = prompt_menu_1_courses(courses)
    
    # Again create an empty screen
    print('\033c', end='')
    if course is not None:
        prompt_menu_2_courses(course)
    else:
        print('info.yaml not found')


if __name__ == '__main__':
    main()
