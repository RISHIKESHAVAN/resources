#!/usr/bin/python -tt
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

"""Wordcount exercise
Google's Python class

The main() below is already defined and complete. It calls print_words()
and print_top() functions which you write.

1. For the --count flag, implement a print_words(filename) function that counts
how often each word appears in the text and prints:
word1 count1
word2 count2
...

Print the above list in order sorted by word (python will sort punctuation to
come before letters -- that's fine). Store all the words as lowercase,
so 'The' and 'the' count as the same word.

2. For the --topcount flag, implement a print_top(filename) which is similar
to print_words() but which prints just the top 20 most common words sorted
so the most common word is first, then the next most common, and so on.

Use str.split() (no arguments) to split on all whitespace.

Workflow: don't build the whole program at once. Get it to an intermediate
milestone and print your data structure and sys.exit(0).
When that's working, try for the next milestone.

Optional: define a helper function to avoid code duplication inside
print_words() and print_top().

"""

import sys

# +++your code here+++
# Define print_words(filename) and print_top(filename) functions.
# You could write a helper utility function that reads a file
# and builds and returns a word/count dict for it.
# Then print_words() and print_top() can just call the utility function.

###
def print_word_count(option, filename):
  word_count = {}
  f = open(filename, 'rU')
  text = f.read()
  words = text.lower().split()
  for word in words:
    if word not in word_count:
      word_count[word] = words.count(word)

  if option == '--count':
    print_words(word_count)
  elif option == '--topcount':
    print_top(word_count)
  else:
    print ('unknown option: ' + option)
    sys.exit(1)
  return


def print_words(word_count):
  for key in sorted(word_count.keys()):
    print(key, word_count[key])

def print_top(word_count):
  sorted_word_count = sorted(word_count.items(), key=count_order, reverse=True)
  if(len(sorted_word_count) < 20):
    n = len(sorted_word_count)
  else:
    n = 20
  for tuple in sorted_word_count[:n]:
    print(tuple[0], tuple[1])

def count_order(tupl):
  return tupl[-1]

# This basic command line argument parsing code is provided and
# calls the print_words() and print_top() functions which you must define.
def main():
  print(sys.argv)
  if len(sys.argv) != 3:
    print ('usage: ./wordcount.py {--count | --topcount} file')
    sys.exit(1)
  print_word_count(sys.argv[1], sys.argv[2])

if __name__ == '__main__':
  main()
