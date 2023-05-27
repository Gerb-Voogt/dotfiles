#!/usr/bin/python3
# -------------------------------------
# FLAGS AND OPTIONS
# -------------------------------------
#   - -c/--concat flag to concat multiple input files together into a single output file name
#       - Otherwise ouptut them as {fileName}-mdpp.md
#   - -o/--output flag to set the output file name. If not specified put as {fileName}-mdpp.md
# -------------------------------------
import sys
import os
import argparse


class MarkdownFile:
    def __init__(self, lines_from_file: list[str], name: str):
        self._name = name
        self._lines = lines_from_file
        if len(self._lines) < 1:
            raise Exception("File does not contain data")

        self._envs = self._find_envs()
        self._blocks = self._find_blocks()
        self._imgs = [] # Unimplemented

    # Rewrite this to modify the self._lines variable outright rather then what its doing now
    def _find_envs(self) -> None:
        for i in range(len(self._lines) - 1):
            if '$$' in self._lines[i] and 'begin' in self._lines[i+1]\
                    and ('align' in self._lines[i+1] or 'gather' in self._lines[i+1]):
                if '>' in self._lines[i]:
                    self._lines[i] = '>'
                else:
                    self._lines[i] = ''
            elif 'end' in self._lines[i] and '$$' in self._lines[i+1]\
                    and ('align' in self._lines[i] or 'gather' in self._lines[i]):
                if '>' in self._lines[i]:
                    self._lines[i+1] = '>'
                else:
                    self._lines[i+1] = ''

    def _find_imgs(self):
        pass

    def _find_blocks(self) -> None:
        block_types = {
                'Theorem': 'theo',
                'theorem': 'theo',
                'Definition': 'defn',
                'definition': 'defn',
                'Question': 'quest',
                'question': 'quest',
                'Proof': 'proof',
                'proof': 'proof',
                'Derivation': 'derivation',
                'derivation': 'derivation',
                'Note': 'note',
                'note': 'note',
                'Example': 'example',
                'example': 'example',
                }
        block_line_count = 0
        block_type = ''
        for i in range(len(self._lines) - 1):
            if r'>' in self._lines[i] and block_line_count == 0:
                if self._lines[i][0] != '>':
                    continue
                block_type = self._lines[i].split()[0].strip('>![]')
                block_title = convert_list_to_string(self._lines[i].split()[1:])
                self._lines[i] = '\\begin{' + block_types[block_type] + '}' + f'[{block_title}]'
                block_line_count += 1

            if r'>' in self._lines[i] and not r'>' in self._lines[i+1]:
                self._lines[i] = self._lines[i].strip('>') + '\\end{' + block_types[block_type] + '}'
                block_line_count = 0

            if r'>' in self._lines[i]:
                self._lines[i] = self._lines[i].strip('>')


    def write_file(self, file_name = None):
        if file_name is not None:
            target = file_name + '.md.p'
        else:
            target = self._name + '.md.p'
        with open(target, 'w') as fb:
            for line in self._lines:
                fb.write(line)


def convert_list_to_string(input_list: list[str]) -> str:
    return_string = ''
    for item in input_list:
        if item != input_list[-1]:
            return_string += (item + ' ')
        else:
            return_string += item
    return return_string


def read_from_file(file_path: str) -> list[str]:
    file_data_list = []
    with open(file_path, 'r') as fb:
        for line in fb:
            file_data_list.append(line)
    return file_data_list


def main():
    try:
        input_file = sys.argv[1]
    except:
        print('No input file given; usage: mdpp fileName.md')
        sys.exit(1)

    try:
        input_file_name, input_file_extension = input_file.split(".")
    except:
        print("Input file must be a md file")
        sys.exit()
    
    if input_file_extension != "md":
        print("Input file must be a md file")
        sys.exit()

    dir = os.getcwd()
    input_file_data = read_from_file(dir + f'/{input_file}')
    data_parsed = MarkdownFile(input_file_data, input_file_name)
    data_parsed.write_file()



if __name__ == "__main__":
	# Define options for cli arguments
	parser = argparse.ArgumentParser(
			prog = 'mdpp',
			description = 'MarkDown PreProcessor to maintain compatability between LaTeX compiled notes via pandoc and Obsidian flavoured Markdown')
	parser.add_argument('-c', '--concat', action = 'store_true')
	parser.add_argument('-o', '--output', action = 'store_true')
	parser.add_argument('filenames') # Look into allowing this to be variable length
	args = parser.parse_args()
	print(args.filenames, args.concat, args.output)

	main()
    
