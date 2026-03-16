function job
    set -l jobs (jobs)

    if test (count $jobs) -eq 0
        echo "No jobs to pick"
        return 1
    end

    set -l pid (printf "%s\n" $jobs | fzf | awk '{print $2}')

    if test -z "$pid"
        echo "Nothing selected"
        return 1
    end


    fg $pid
end
