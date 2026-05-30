#!/usr/bin/env fish
set chosen (apps.py | fzf --border=none --with-nth=1 --delimiter='\t' --height=100%)
if test -z "$chosen"
    exit 0
end

set cmd (echo $chosen | cut -f2)
set parts (string split " " $cmd)

systemd-run --user --no-block $parts
