#!/usr/bin/env python3
import fileinput
import re
from collections import namedtuple

CommandAndOutput = namedtuple('CommandAndOutput', ['command', 'output'])
ParsedCommand = namedtuple('ParsedCommand', ['command', 'output', 'qflist'])

def parseRg(output):
  qflist = []
  filename = ""

  #output is like:
  #filename
  #line:col: text
  #line:col: text
  #<blank>
  #filename
  for line in output:
    if not line:
      filename = ""
      continue
    if not filename:
      filename=line
      continue

    qflist.append(filename + ":" + line)

  return qflist

# input: output of single command (prompt and command invoke omited) # [stripped-lines]
# return: a qf list from output
def parseOutput(command, output):
  # choose parser based on last command in pipeline
  command = command.split(" | ")[-1]

  # TODO implement a git diff parser, there is already a vim one :GitDiffQuickFix, uses ~/BASH/vim/gitdiffqf.py
  # if re.compile("^git diff").search(command):
  #   return parseGitDiff(output)

  if re.compile("(?:^| \| )(xargs )?rg ").search(command):
    return parseRg(output)

  # BASH version grep -P "^[a-z,A-Z,_,0-9,\/\.,-]+:[0-9]+(:[0-9]+)?:"
  qf_matcher = re.compile("^[a-z,A-Z,_,0-9,\/\.,\-,~]+:[0-9]+(:[0-9]+)?:")
  # no matches will return Falsey empty list
  return [line for line in output if qf_matcher.search(line)]


# lines: list of input stream lines, stripped
# returns an ordered collection of (cmd, output)
def seperateAllCommands(lines):
  prompt_matcher = re.compile("^\S+ ❱ ")
  prompt_line_numbers = [num for num,line in enumerate(lines) if prompt_matcher.search(line)]

  # NOTE some commands like cd have no output, second item in tuple will be ''
  return [
      CommandAndOutput(
          command=prompt_matcher.split(lines[start])[-1].strip(),
          output=list(lines[start+1:next_start])
      )
      for start, next_start in zip(prompt_line_numbers, prompt_line_numbers[1:] + [len(lines)])
      if next_start > start+1 # remove commands with no output
  ]

# the public interface for this file
#  reads: [] of stripped lines from tmux buffer
# writes: [] of parsedcommands (command, output, qflist)
def get_quickfixlists(striped_lines_list):
  # expected input: full tmux buffer contents with > unicode prompt
  commands_and_output = seperateAllCommands(striped_lines_list)

  return list(filter(
      lambda x: x.qflist, # ensure the qf list is non-empty
      (ParsedCommand(command=item.command, output=item.output, qflist=parseOutput(item.command, item.output))
       for item in commands_and_output)
  ))

#  reads: raw tmux buffer text from stdin || arg specified file-desc
# writes: a human readable list of parsed qf lists
# NOTE for dev/test only, otherwise use get_quickfixlists()
def main():
  parsed_commands = get_quickfixlists([line.strip() for line in fileinput.input()])

  for item in parsed_commands:
    print( "*************", item.command, "*************" )
    print( "\n".join(item.qflist) )
    print( "" )
    print( "" )


if __name__ == '__main__':
  main()

