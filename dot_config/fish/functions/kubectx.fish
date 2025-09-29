function kubectx -d 'kubectl - use context'
    kubectl config get-contexts | tail -n +2 | awk '{print $2}' | string trim | fzf | read -l result; and kubectl config use-context $result
end
