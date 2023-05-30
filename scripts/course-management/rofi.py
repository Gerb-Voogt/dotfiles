#!/usr/bin/python3
#----------------------------
# Code stolen from Gilles Castel
# https://github.com/gillescastel/university-setup/blob/master/scripts/rofi.py
#----------------------------
import subprocess

def rofi(prompt, options, rofi_args=[], fuzzy=True):
    optionstr = '\n'.join(option.replace('\n', ' ') for option in options)
    args = ['rofi', '-sort', '-no-levenshtein-sort']
    if fuzzy:
        args += ['-matching', 'fuzzy']
    args += ['-dmenu', '-p', prompt, '-format', 's', '-i']
    args += rofi_args
    args = [str(arg) for arg in args]


    result = subprocess.run(args, input=optionstr, stdout=subprocess.PIPE, universal_newlines=True)
    stdout = result.stdout.strip()

    selected = stdout.strip()
    try:
        index = [opt.strip() for opt in options].index(selected)
    except ValueError:
        index = -1

    return index, selected
