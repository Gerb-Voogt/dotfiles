#!/usr/bin/python3
import sys

try:
    if len(sys.argv) > 1:
        PATH = str(sys.argv[1])
    else:
        PATH = sys.stdin.read()
        
except:
    print('No file passed!')
    sys.exit(0)

PATHS = PATH.split('\n')
for file in PATHS:
    print(file.split('/')[-1])
