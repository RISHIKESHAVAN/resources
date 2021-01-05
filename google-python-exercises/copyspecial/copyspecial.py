#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re
import os
import shutil
import subprocess

"""Copy Special exercise
"""

# +++your code here+++
# Write functions and modify main() to call them
def get_special_paths(dir):
  abspaths=[]
  dirs = os.listdir(dir)
  for d in dirs:
    matcher = re.search('__\w+__', d)
    if matcher:
      full_dir = os.path.join(dir,d)
      abspaths.append(os.path.abspath(full_dir))
  return abspaths

def copy_to(paths, dir):
  for filepath in paths:
    print('Copying ', filepath, 'to', dir)
    shutil.copy(filepath, dir)

def zip_to(paths, zippath):
  cmd = 'zip -j '+ zippath
  for filepath in paths:
    cmd = cmd + ' ' + filepath
  print('Command to be executed:', cmd)
  process = subprocess.run(cmd)
  if process.returncode:
    print(process.stderr)


def main():
  # This basic command line argument parsing code is provided.
  # Add code to call your functions below.

  # Make a list of command line arguments, omitting the [0] element
  # which is the script itself.
  args = sys.argv[1:]
  if not args:
    print("usage: [--todir dir][--tozip zipfile] dir [dir ...]")
    sys.exit(1)

  # todir and tozip are either set from command line
  # or left as the empty string.
  # The args array is left just containing the dirs.
  todir = ''
  if args[0] == '--todir':
    todir = args[1]
    del args[0:2]
    print('Copying from: [', args[0], '] to: [', todir,']')
    copy_to(get_special_paths(args[0]),todir)
    sys.exit(1)

  tozip = ''
  if args[0] == '--tozip':
    tozip = args[1]
    del args[0:2]
    print('Copying from: [', args[0], '] zipping to: [', tozip,']')
    zip_to(get_special_paths(args[0]),tozip)
    sys.exit(1)

  if len(args) == 0:
    print("error: must specify one or more dirs")
    sys.exit(1)

  # +++your code here+++
  # Call your functions
  
if __name__ == "__main__":
  main()
