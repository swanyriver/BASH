#!/usr/bin/env bash

# using fzf for columnar select
# n=fuzzy-select,  accept=stdout with-nth = displayed column (no need to pre-awk)
# fzf -n 1 --accept-nth 1 --with-nth 1,3,4
# symbol, code, type     # omit file name

# sed is to remove the start,end marks on code snippets

# if no piped file names use file-picker
if [ $# -eq 0 ]; then
  source ~/.non_interactive_rc; 
  eval $FZF_CTRL_T_COMMAND \
    | fzf-tmux -p 90%,90% --layout=default \
    | tr -d '\n' \
    | tmux loadb -b AGENT_FILE_BUF /dev/stdin
else
  echo -n $@ | tmux loadb -b AGENT_FILE_BUF /dev/stdin
fi 

ctags -o - -u --fields=+K $(tmux showb -b AGENT_FILE_BUF) 2>/dev/null \
   | cut -f 1,3,4 |  sed 's|/\^||; s|\$/;"||' | column -t -s $'\t' \
   | fzf-tmux -p 90%,90% --layout=default -n 1 --accept-nth 1 \
   | tr -d '\n' | tmux loadb -b TO_AGENT_BUF /dev/stdin;

tmux paste-buffer -d -b TO_AGENT_BUF
