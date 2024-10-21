if status is-interactive
  function starship_transient_prompt_func
    starship module character
  end
  starship init fish | source
  enable_transience
  zoxide init fish | source
  fzf --fish | source
  direnv hook fish | source
end

