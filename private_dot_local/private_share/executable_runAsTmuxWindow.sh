#!/usr/bin/env sh

uwsm app -- kitty.desktop &

name="$1"
cmd="$2"
shift 2
args="$1"

if [ -n "$args" ]; then
  case "$cmd" in
  lazygit)
    tmux new-window -t MAIN -n "$name" "$cmd" -p "$args"
    ;;
  *)
    tmux new-window -t MAIN -n "$name" "$cmd" "$args"
    ;;
  esac
else
  tmux new-window -t MAIN -n "$name" "$cmd"
fi
