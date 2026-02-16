return {
    src = 'https://github.com/mcauley-penney/techbase.nvim',
    setup = function()
        require('techbase').setup({})
        vim.cmd.colorscheme('techbase')
        vim.api.nvim_set_hl(0, 'DiagnosticHint', { link = 'DiagnosticInfo' })
    end,
}
