#!/usr/bin/env bash

if [ ! -f /etc/arch-release ]; then
  exit 0
fi
UPDATES=$(yay -Qu | wc -l)

CLASS="warning"
if [ "$UPDATES" = "0" ]; then
  CLASS="ok"
fi
echo "{\"text\": \"$UPDATES\", \"class\": \"$CLASS\"}"
exit 0
