#!/bin/bash

RPM=$(cat /sys/class/hwmon/hwmon6/fan1_input)
RUNNING=󰈐
NOT_RUNNING=󰠝
CLASS="off"
ICON=$NOT_RUNNING
if [ $RPM != 0 ]; then
  CLASS="on"
  ICON=$RUNNING
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"RPM: $RPM\", \"class\": \"$CLASS\"}"
