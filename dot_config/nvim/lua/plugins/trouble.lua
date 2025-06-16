return {
    'folke/trouble.nvim',
    opts = {
        auto_preview = false,
        auto_close = true,
    },
    keys = {
        {
            '<leader>tt',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
        },
    },
}
