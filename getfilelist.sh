#!/bin/bash
# NOTE: non_interactive_rc must have at least: _fzf_opts_and_tmux_settings
source ~/.non_interactive_rc; 
cd ${1:-.};
eval $FZF_CTRL_T_COMMAND
