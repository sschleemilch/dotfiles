#!/usr/bin/env bash

config=launcher.rasi

actions=$(echo -e "  Shutdown\n  Reboot\n  Logout")

selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" -theme-str "listview {lines: 3;}" || pkill -x rofi)

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
