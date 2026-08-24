function color -d 'change colorscheme'
    set -l colors "rose-pine" "rose-pine-dawn" "rose-pine-moon" "tokyonight-night" "kanagawa" "catppuccin-mocha" "carbonfox" "vague" "alabaster" "alabaster-dark"
    set -l config_file ~/.config/chezmoi/chezmoi.toml
    set -l selected_color (printf "%s\n" $colors | fzf)

    if test -n "$selected_color"
        echo "setting colorscheme '$selected_color'"
        sed "s/colorscheme = \".*\"/colorscheme = \"$selected_color\"/" "$config_file" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"
        chezmoi apply
        if set -q KITTY_PID
            kitten @ action load_config_file
        end
        if set -q TMUX
            tmux source ~/.config/tmux/tmux.conf
        end
        . ~/.config/fish/config.fish
    else
        echo "No color scheme selected"
    end
end
