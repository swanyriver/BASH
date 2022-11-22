#!/usr/bin/env python3
import fileinput
import re

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
# waiting for first @@ to get line number (print file and line number)
# reading and parroting change lines, watching for @@
# keep print filename and line number until new file found
file_matcher = re.compile("^diff \S+ \S+ b/(\S+)$")
line_number_and_line_text_matcher = re.compile("^@@ -\d+[\,,\ ,\d]+\+(\d+)[\,,\ ,\d]+@@(.*)");

def parsediff(lines):
  current_file=""
  found_first_line_number = False
  for line in lines:
    file_name_match = file_matcher.match(line)
    if file_name_match:
      current_file=file_name_match.group(1)
      found_first_line_number = False
      continue

    line_info_match = line_number_and_line_text_matcher.match(line)
    if not line_info_match and not found_first_line_number:
      continue # between the diff line and the @@ line
    if not line_info_match:
      print( line ) # a +/- diff line
      continue

    line_number, line_text = line_info_match.groups()
    found_first_line_number = True
    print ("%s:%s:%s"%(current_file, line_number, line_text))


def main():
  parsediff(x.strip() for x in fileinput.input() if x.strip())


if __name__ == '__main__':
  main()

