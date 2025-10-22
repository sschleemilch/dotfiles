function groot -d 'cd into git root'
    cd $(git rev-parse --show-toplevel)
end
