#!/bin/env bash

current_subvol=$(findmnt -no OPTIONS / | grep -oP 'subvol=\K\S+')

if [[ "$current_subvol" != "/@" ]]; then
  notify-send -a Timeshift -u critical -w "You are currently running from snapshot: $current_subvol"
fi
