#!/usr/bin/env python3
# used for transforming return seperated items into delimiter (-d) seperated
import fileinput
import sys

joiner = " "
if "-d" in sys.argv and len(sys.argv) >= sys.argv.index("-d") + 2:
  joiner = sys.argv[sys.argv.index("-d") + 1]
  del sys.argv[sys.argv.index("-d"):sys.argv.index("-d")+2]

lines = (x.strip() for x in fileinput.input() if x.strip())

print (joiner.join(lines))
