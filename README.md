<h3 align="center">
 <img src="https://avatars.githubusercontent.com/u/12069137?v=4" width="100" alt="Logo"/><br/>
 Dotfiles for <a href="https://github.com/sschleemilch">sschleemilch</a>
</h3>

[![Linux](https://img.shields.io/badge/Linux-cad3f5?style=for-the-badge&logo=linux&logoColor=black)](https://github.com/sschleemilch/dotfiles/blob/main)
[![Neovim](https://img.shields.io/badge/Neovim-cad3f5?style=for-the-badge&logo=neovim&logoColor=black)](https://neovim.io/)
[![Kitty](https://img.shields.io/badge/Kitty-cad3f5?style=for-the-badge&logo=gnometerminal&logoColor=black)](https://sw.kovidgoyal.net/kitty/)
[![Fish](https://img.shields.io/badge/Fish-cad3f5?style=for-the-badge&logo=fishshell&logoColor=black)](https://fishshell.com/)
[![FZF](https://img.shields.io/badge/FZF-cad3f5?style=for-the-badge&logo=searxng&logoColor=black)](https://github.com/junegunn/fzf)
[![Starship](https://img.shields.io/badge/Starship-cad3f5?style=for-the-badge&logo=starship&logoColor=black)](https://starship.rs/)
[![Direnv](https://img.shields.io/badge/Direnv-cad3f5?style=for-the-badge&logo=dotenv&logoColor=black)](https://github.com/direnv/direnv)
[![Zoxide](https://img.shields.io/badge/Zoxide-cad3f5?style=for-the-badge&logo=files&logoColor=black)](https://github.com/ajeetdsouza/zoxide)

My dotfiles managed with [chezmoi](https://www.chezmoi.io/).

`~/.config/chezmoi/chezmoi.toml` data values:

```toml
[data]
  email = "<email>"
  network_interface = "wlp0s20f3" # only for `waybar`
  colorscheme = "<rose-pine|tokyonight|kanagawa|catppuccin"
```

## Dependencies

### `nvim`

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [node.js](https://nodejs.org)
- [fzf](https://github.com/junegunn/fzf)

### `fish`

- [starship](https://starship.rs/)
- [direnv](https://direnv.net/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

### `kitty`

- [MonoLisa](https://www.monolisa.dev/)

### `ghostty`

- [MonoLisa](https://www.monolisa.dev/)

### `waybar`, `rofi`, `dunst`

- waybar: [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip)
- rofi, dunst: [MonoLisa](https://www.monolisa.dev/)

### `hypr`

- Existing `~/wallpaper.png`
- [Orbitron](https://github.com/theleagueof/orbitron) for `hyprlock`

### `tmux`

- [tpm](https://github.com/tmux-plugins/tpm)
