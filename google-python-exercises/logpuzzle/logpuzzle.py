#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import os
import re
import sys
import urllib
import urllib.request

"""Logpuzzle exercise
Given an apache logfile, find the puzzle urls and download the images.

Here's what a puzzle url looks like:
10.254.254.28 - - [06/Aug/2007:00:13:48 -0700] "GET /~foo/puzzle-bar-aaab.jpg HTTP/1.0" 302 528 "-" "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6"
"""

def url_sort_key(url):
  """Used to order the urls in increasing order by 2nd word if present."""
  match = re.search(r'-(\w+)-(\w+)\.\w+', url)
  if match:
    print(match.group(2))
    return match.group(2)
  else:
    return url

def read_urls(filename):
  """Returns a list of the puzzle urls from the given log file,
  extracting the hostname from the filename itself.
  Screens out duplicate urls and returns the urls sorted into
  increasing order."""
  # +++your code here+++
  urls = []
  hosturl = 'http://' + re.search('\w+_(\w+\.\w+\.com)',filename).group(1)
  print('Fetching from host:',hosturl)
  f = open(filename, 'r')
  for line in f:
    m = re.search('GET\s(\S+puzzle\S+)\s', line)
    if m:
      img_url = hosturl+m.group(1)
      if img_url not in urls:
        urls.append(img_url)
  f.close()
  print('Number of image urls:',len(urls))
  return sorted(urls, key=url_sort_key)

def download_images(img_urls, dest_dir):
  """Given the urls already in the correct order, downloads
  each image into the given directory.
  Gives the images local filenames img0, img1, and so on.
  Creates an index.html in the directory
  with an img tag to show each local image file.
  Creates the directory if necessary.
  """
  # +++your code here+++
  if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)
  html_file = open(os.path.join(dest_dir, 'index.html'),'w')

  i = 0
  img_tag = '<img src="{}">'
  html_img_string = ''
  path_to_image = os.path.abspath(dest_dir)
  for url in img_urls:
    img_name = 'img%d' % i
    urllib.request.urlretrieve(url, os.path.join(path_to_image,img_name))
    html_img_string = html_img_string + img_tag.format(img_name)
    i = i+1
  html_file.write('<html><body>\n'+html_img_string+'\n</html></body>')
  html_file.close()
  

def main():
  args = sys.argv[1:]

  if not args:
    print('usage: [--todir dir] logfile ') 
    sys.exit(1)

  todir = ''
  if args[0] == '--todir':
    todir = args[1]
    del args[0:2]

  img_urls = read_urls(args[0])

  #fff = open('urls3.txt', 'w')
  #for u in img_urls:
  #  fff.write(u)
  #  fff.write('\n')
  #fff.close()

  if todir:
    download_images(img_urls, todir)
  else:
    print('\n'.join(img_urls))

if __name__ == '__main__':
  main()
