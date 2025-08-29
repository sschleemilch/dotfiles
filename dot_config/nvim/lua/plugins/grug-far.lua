return {
    src = 'https://github.com/MagicDuck/grug-far.nvim',
    setup = function()
        require('grug-far').setup()
        vim.keymap.set({ 'n', 'v' }, '<leader>gf', '<cmd>GrugFar<cr>', { desc = 'Replace in files (Grug-far)' })
    end,
}
