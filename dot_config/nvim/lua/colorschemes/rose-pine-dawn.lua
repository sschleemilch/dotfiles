return {
    src = 'https://github.com/rose-pine/neovim',
    setup = function()
        require('rose-pine').setup({
            styles = {
                italic = false,
                bold = false
            },
        })
        vim.cmd.colorscheme('rose-pine-dawn')
    end,
}
