#!/usr/bin/env python3
import fileinput
import qf_maker
import sys
import subprocess

#  reads: raw tmux buffer text from stdin
# writes: qf-formated list of matches [file]:[line]:[col]  text
def main():
  # use first arg because it is result of recieving <(cat)
  parsed_commands = qf_maker.get_quickfixlists([line.rstrip() for line in fileinput.input(files=sys.argv[1])])
  chosen_cmd = None
  if len(sys.argv) > 2 and "--last" in sys.argv[2:]:
    chosen_cmd = parsed_commands[-1]
  else:
    choiceList = (f"{idx}) ({len(cmd.qflist)} matches): {cmd.command}" for idx,cmd in enumerate(parsed_commands))
    choiceListSring = "\n".join(choiceList)
    choice_index_str = subprocess.check_output(f"echo -e '{choiceListSring}' | tac | fzy", shell=True).decode("utf-8")
    choice=int(choice_index_str.split(")")[0]) # todo regex would be better
    chosen_cmd = parsed_commands[choice]

  if not chosen_cmd:
    exit()
  sys.stderr.write("\n".join(chosen_cmd.qflist) + "\n")


if __name__ == '__main__':
  main()


