#!/usr/bin/env python3
# slightly more convinient version of `uniq -c`, because it sorted and num is first
import collections
import fileinput

lines = (x.strip() for x in fileinput.input() if x.strip())

cnt = collections.Counter(lines)

for name, num in cnt.most_common():
  print (num, name)
