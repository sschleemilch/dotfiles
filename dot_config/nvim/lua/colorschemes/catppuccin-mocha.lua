return {
    src = 'https://github.com/catppuccin/nvim',
    setup = function()
        require('catppuccin').setup({})
        vim.cmd.colorscheme('catppuccin-mocha')
    end,
}
