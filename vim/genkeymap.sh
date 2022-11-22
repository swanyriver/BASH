#!/bin/bash
# usage genkeymap.sh outputfile.txt filetypetocheck.cc
$VISUAL $2 -c ":redir! > $1" -c ":silent map" -c ":redir END" -c ":q"
sed -i "s/<SNR>[0-9]*_/<SNR>/g" $1
