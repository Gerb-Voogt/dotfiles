#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  # Select path piped in via stdin
  selected=$1
else
  # and open fzf otherwise
  selected=`find /home/gerben/uni/ -type d -name .git | sed 's/\.git//' | fzf`
fi

if [[ -z "$selected" ]]; then
  exit 0
fi

tmux_running=$(pgrep 'tmux')
repo_name=$(basename $selected)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  # Create a tmux instance if tmux is not already running
  tmux new-session -s $repo_name -c $selected
  exit 0
fi

# Open a tmux session at the repo if tmux is already running
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $repo_name -c $selected
fi

tmux switch-client -t $repo_name

