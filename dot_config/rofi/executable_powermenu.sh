#!/usr/bin/env bash

shutdown=''
reboot=''
lock='󰌾'
logout='󰍃'

rofi_cmd() {
  rofi -dmenu -theme powermenu.rasi
}

run_rofi() {
  echo -e "$lock\n$shutdown\n$logout\n$reboot" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  hyprlock
  ;;
$logout)
  hyprctl dispatch exit
  ;;
esac
