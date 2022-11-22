#!/bin/bash
$VISUAL $2 -c ":redir! > $1" -c ":silent scriptnames" -c ":redir END" -c ":q"
awk '{print $2}' $1 | sponge $1
