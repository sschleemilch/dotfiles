#!/usr/bin/env bash

config=launcher.rasi

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n  Logout")

selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" -run-command "uwsm app -- {cmd}" || pkill -x rofi)

case "$selected_option" in
*Lock)
  hyprlock
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Reboot)
  systemctl reboot
  ;;
*Suspend)
  systemctl suspend
  ;;
*Hibernate)
  systemctl hibernate
  ;;
*Logout)
  hyprctl dispatch exit
  ;;
esac
