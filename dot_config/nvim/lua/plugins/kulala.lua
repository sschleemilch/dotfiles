return {
    src = 'https://github.com/mistweaverco/kulala.nvim',
    setup = function()
        require('kulala').setup({
            global_keymaps = true,
            global_keymaps_prefix = '<localleader>R',
        })
    end,
}
