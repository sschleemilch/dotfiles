return {
    src = 'https://github.com/rose-pine/neovim',
    setup = function()
        require('rose-pine').setup({})
        vim.cmd.colorscheme('rose-pine-moon')
    end,
}
