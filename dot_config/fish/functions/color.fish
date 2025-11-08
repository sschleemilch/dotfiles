function color -d 'change colorscheme'
    set -l colors "rose-pine" "rose-pine-dawn" "rose-pine-moon" "tokyonight-night" "kanagawa" "catppuccin-mocha" "carbonfox" "techbase" "vague"
    set -l config_file ~/.config/chezmoi/chezmoi.toml
    set -l selected_color (printf "%s\n" $colors | fzf)

    if test -n "$selected_color"
        echo "setting colorscheme '$selected_color'"
        sed "s/colorscheme = \".*\"/colorscheme = \"$selected_color\"/" "$config_file" > "$config_file.tmp" && mv "$config_file.tmp" "$config_file"
        chezmoi apply
        # kitten @ action load_config_file
        . ~/.config/fish/config.fish
    else
        echo "No color scheme selected"
    end
end
