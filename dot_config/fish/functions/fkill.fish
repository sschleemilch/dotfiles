function fkill
    set -l pid
    if test "$USER" != "root"
        set pid (ps -f -u $USER | sed 1d | fzf -m | awk '{print $2}')
    else
        set pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    end

    if test -n "$pid"
        echo $pid | xargs kill -$argv[1]
    end
end
