#!/bin/sh

systemctl --user is-active --quiet "app-Hyprland-${1}-*.scope" ||
  uwsm app -- ${1} &
hyprctl dispatch focuswindow class:${1}
