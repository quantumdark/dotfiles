#!/usr/bin/env bash

XKB_DIR="$HOME/.config/xkb"
XKB_SYMBOL_FILE="my"

if [[ -n $(which setxkbmap) && -n $(which xkbcomp) ]]; then
    setxkbmap -layout "us+$XKB_SYMBOL_FILE(my),ru(winkeys)" \
    -option "" -option "grp:alt_shift_toggle" -print \
    | xkbcomp -I"$XKB_DIR" - "${DISPLAY%%.*}" >/dev/null 2>&1
fi
#setxkbmap -symbols my -print | xkbcomp -I"$HOME/.config/xkb" - "${DISPLAY%%.*}"
#-option "" -option "grp:caps_toggle,grp_led:caps" -print \
#-option "" -option "grp:caps_toggle,grp_led:caps" -print \
