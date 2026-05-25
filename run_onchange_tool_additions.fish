#!/usr/bin/env fish

# TMUX tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
