MiniDeps.later(function()
    MiniDeps.add('folke/trouble.nvim')
    require('trouble').setup({
        auto_preview = false,
        auto_close = true,
    })
    vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (trouble)' })
end)
