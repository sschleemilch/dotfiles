return {
    src = 'https://github.com/rose-pine/neovim',
    setup = function()
        require('rose-pine').setup({
            styles = {
                italic = false,
            },
        })
        vim.cmd.colorscheme('rose-pine')
    end,
}
