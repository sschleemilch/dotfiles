#!/usr/bin/env bash

config=powermenu.rasi

actions=$(echo -e "  Shutdown\n  Reboot\n  Logout")

selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" || pkill -x rofi)

case "$selected_option" in
*Shutdown)
  systemctl poweroff
  ;;
*Reboot)
  systemctl reboot
  ;;
*Logout)
  uwsm stop
  ;;
esac
