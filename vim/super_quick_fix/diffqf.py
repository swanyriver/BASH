#!/usr/bin/env python3
import fileinput
import re
import os
from itertools import zip_longest

# there will be:
# diff --git a/file b/file
# index #############
# --- a/file
# +++ b/file
# @@ line-prev,* line-now,* @@ first line
# lines of changes
# @@ line-prev,* line-now,* @@ first line (same file)
# lines of changes
#
# this will be in a state of:
# getting file name from a diff
# waiting for first @@ to get context line number (print file and line number)
# incrementing line-count for non-symbol line
# printing hunk qf when new symbol encountered
# keep print filename and line number until new file found

diff_begining_re = re.compile(r"^diff --git a/\S* b/\S*")
file_re = re.compile(r"^\+\+\+ b/(\S+)$")
new_hunk_re = re.compile(r"^@@ -\d+[\,,\ ,\d]+\+(\d+)[\,,\ ,\d]+@@.*");

def parsediff(lines):
  returns=[]
  filename = ""
  linenumber = 0
  inhunk = False
  cached_deletion_line = ""

  for line in lines:
    diff_begining_match = diff_begining_re.match(line)
    if (diff_begining_match):
      inhunk = False
      filename = ""
      continue

    file_match = file_re.match(line)
    if file_match:
      filename = file_match.group(1)
      inhunk = False
      continue


    new_hunk_match = new_hunk_re.match(line)
    if new_hunk_match:
      linenumber=int(new_hunk_match.group(1)) - 1
      inhunk = False
      continue

    if not filename:
      # still in file header area, or binary diff
      continue

    if (not line) or (line[0] != "+" and line[0] != "-"):
      inhunk = False

      # exited hunk without printing, happens for deletions
      if cached_deletion_line:
        returns.append(cached_deletion_line)
        cached_deletion_line=""

      linenumber += 1
      continue

    # diff line with +/- as first char

    # start of deletion|mod hunk
    if not inhunk and line[0] == "-":
        cached_deletion_line = "{}:{}:{}".format(filename,linenumber,line)
        inhunk = True
        continue

    if line[0] == "+":
      # line number increases on additions
      linenumber += 1

      # start of additon hunk or first line of modification
      if not inhunk or cached_deletion_line:
        inhunk = True
        returns.append("{}:{}:{}".format(filename,linenumber,line))
        cached_deletion_line = ""


  return striproot(returns)


def striproot(input):
  if not input: return input

  tobetrimmed=0
  roots=reversed(os.getcwd().split("/"))
  filedirs=input[0].split(":")[0].split("/")
  for root, filedir in zip_longest(roots, filedirs):
    if root == filedir:
      tobetrimmed += len(root) + 1
    else:
      break

  if tobetrimmed:
    return (x[tobetrimmed:] for x in input)

  return input


def main():
  results = parsediff(x.rstrip() for x in fileinput.input())
  print("\n".join(results))


if __name__ == '__main__':
  main()

