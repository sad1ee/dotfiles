#!/bin/bash

# Simple script to check the time and turn hyprsunet on or off
# Check current time and status of hyprsunset

current_time=$(date +"%H")
hyprcheck=$(pgrep hyprsunset)

# Log current time and hyprsunset status for debugging
echo "$(date): current_time=$current_time, hyprcheck=$hyprcheck" >> /tmp/hyprlight.log


#if after 10pm start hyrpsunset at temp 5000
# if between 8am-10pm, kill hyprsunset

if ([[ $current_time -ge 22 ]] || [[ $current_time -lt 8 ]]) && [[ -z $hyprcheck ]]; then
    echo "$(date): Starting hyprsunset" >> /tmp/hyprlight.log
  /usr/bin/hyprsunset -t 5000
elif [[ $current_time -ge 8 ]] && [[ $current_time -lt 22 ]] && [[ -n $hyprcheck ]]; then
  echo "$(date): Stopping hyprsunset" >> /tmp/hyprlight.log
  pkill hyprsunset
else
    echo "$(date): No action taken" >> /tmp/hyprlight.log
fi
