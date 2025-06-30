function gcb -d 'git - Checkout branch with fzf'
    git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout (echo "$result" | sed "s/remotes\/[^/]*\///")
end
