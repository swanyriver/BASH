#!/usr/bin/env python3
# first unique occurance for each is shown
import fileinput

lines = (x.strip() for x in fileinput.input() if x.strip())
unique_lines = []
already_found = set()
for line in lines:
    if line not in already_found:
        unique_lines.append(line)
        already_found.add(line)

print( "\n".join(unique_lines))
