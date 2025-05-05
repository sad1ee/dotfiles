#!/bin/env bash

sleep 0.5

MONITOR_1=$1
MONITOR_2=$2
TRIES=0
MAX_TRIES=5
WORKSPACES=10

while ! hyprctl monitors | grep -q "$1"; do
  ((TRIES++))
  if [ "$TRIES" -ge "$MAX_TRIES" ]; then
    printf "[MOVE_WORKSPACE] MAX_TRIES (%d) exceeded\n" $MAX_TRIES
    exit 1
  fi
  sleep 1
done

if [ ! -z "${MONITOR_2}" ]; then
  hyprctl dispatch workspace 10
  hyprctl dispatch moveworkspacetomonitor 10 "desc:$MONITOR_2"
  ((WORKSPACES--))
  printf "[MOVE_MONITOR] Set %s to 10\n" "$MONITOR_2"
fi

for workspace in $(seq 1 $WORKSPACES); do
  hyprctl dispatch moveworkspacetomonitor $workspace "desc:$MONITOR_1"
  printf "[MOVE_WORKSPACE] %d to %s\n" $workspace "$MONITOR_1"
done

hyprctl dispatch workspace 1
hyprctl reload
