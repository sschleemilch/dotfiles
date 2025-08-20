function color -d 'change colorscheme'
    set -l colors "rose-pine" "tokyonight" "kanagawa" "catppuccin" "carbonfox"
    set -l config_file ~/.config/chezmoi/chezmoi.toml
    set -l selected_color (printf "%s\n" $colors | fzf)

    if test -n "$selected_color"
        sed -i '' "s/colorscheme = \".*\"/colorscheme = \"$selected_color\"/" $config_file
        echo "Colorscheme updated to $selected_color"
        chezmoi apply
        kitten @ action load_config_file
        . ~/.config/fish/config.fish
    else
        echo "No color scheme selected"
    end
end
