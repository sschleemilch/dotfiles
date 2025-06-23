function tm
  if test -n "$TMUX"
    set change "switch-client"
  else
    set change "attach-session"
  end

  if test -n "$argv[1]"
    tmux $change -t "$argv[1]" 2> /dev/null
    or begin
      tmux new-session -d -s "$argv[1]"
      and tmux $change -t "$argv[1]"
    end
    return
  end

  set -l session (tmux list-sessions -F "#{session_name}" 2> /dev/null | fzf --exit-0)

  if test -n "$session"
    tmux $change -t "$session"
  else
    tmux new-session -s default
  end
end
