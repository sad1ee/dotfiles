#!/bin/bash
hyprctl binds -j |
  jq -r '
    map({mod:.modmask|tostring,key:.key,code:.keycode|tostring,desc:.description,dp:.dispatcher,arg:.arg,sub:.submap}) |
    map(.mod |= {"0":"","1":"SHIFT+","4":"CTRL+","5":"SHIFT+CTRL+","64":"SUPER+","65":"SUPER+SHIFT+","68":"SUPER+CTRL+","8":"ALT+"} [.]) |
    map(.code |= {"59":"Comma","60":"Dot"} [.]) |
    sort_by(.mod) | .[] |
    select(.sub == "") |
    "\(.mod)\(if .key == "" then .code else .key end) |\(.desc) \(.dp) \(.arg)" ' |
  tofi --width 100% --height 100%
