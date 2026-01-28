#!/usr/bin/bash

#  if change then change clipboard_read.sh
CLIPBOARD_SINK_DIR="${HOME}/.clipboard_sink"
if [[ ! -d "$CLIPBOARD_SINK_DIR" ]]; then
  mkdir "$CLIPBOARD_SINK_DIR"
fi
CLIPBOARD_SINK="${CLIPBOARD_SINK_DIR}/clipboard"
if [[ ! -e "$CLIPBOARD_SINK" ]]; then
  touch "$CLIPBOARD_SINK"
fi

# TODO ssh-connection method not working for detecting remote session
# if [[ -z "${SSH_CONNECTION}" ]]; then
  # LOCAL
  # cat /dev/stdin | tee $CLIPBOARD_SINK  | wl-copy
# else
  # REMOTE
  # cat /dev/stdin > $CLIPBOARD_SINK
# fi


# local only:
cat /dev/stdin | wl-copy
