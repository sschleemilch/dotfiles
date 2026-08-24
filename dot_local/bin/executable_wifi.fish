#!/usr/bin/env fish

if not command -v nmcli >/dev/null 2>&1; or not command -v fzf >/dev/null 2>&1
    echo "Error: nmcli or fzf not found. Please install them to use this script."
    exit 1
end

set selected_network (nmcli --terse --fields "SSID,BARS,SECURITY" device wifi list \
    | grep -v "^:" \
    | sed 's/:/\t/g' \
    | fzf --height 100% --border none)

test -z "$selected_network"; and exit

set ssid (echo "$selected_network" | cut -f1)

if nmcli connection show | grep -q "$ssid"
    nmcli connection up "$ssid"
else
    nmcli device wifi connect "$ssid" password --ask
end
