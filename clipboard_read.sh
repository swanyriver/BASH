#!/usr/bin/bash

if [[ $# -lt 1 ]]; then
  echo "must supply host:dir"
  exit
fi

#  if change then change clipboard_send.sh
CLIPBOARD_SOURCE_DIR="${HOME}/.clipboard_source"
CLIPBOARD_SOURCE_FILE="${CLIPBOARD_SOURCE_DIR}/clipboard"

if [[ ! -d "$CLIPBOARD_SOURCE_DIR" ]]; then
  mkdir "$CLIPBOARD_SOURCE_DIR"
fi

sshfs ${1} $CLIPBOARD_SOURCE_DIR

# TODO use a trap and perform cleanup for sigint
# TODO seems to clean itself up since it is in this shell
echo "to cleanup:"
echo "fusermount -u $CLIPBOARD_SOURCE_DIR"

echo "press enter to begin reading: $CLIPBOARD_SOURCE_FILE"
ls -lrt $CLIPBOARD_SOURCE_FILE
read _

shacache=""
newsha=""

while true; do
  newsha=$(sha256sum $CLIPBOARD_SOURCE_FILE | cut -f 1 -d " ")
  if [[ "$newsha"  != "$shacache" && -s $CLIPBOARD_SOURCE_FILE ]]; then
    echo "reading $CLIPBOARD_SOURCE_FILE"
    cat $CLIPBOARD_SOURCE_FILE | wl-copy
    shacache=$newsha
    # cat /dev/null > $CLIPBOARD_SOURCE_FILE
  fi
  sleep .05;
done
