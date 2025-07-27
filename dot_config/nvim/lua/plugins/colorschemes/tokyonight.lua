MiniDeps.now(function()
    MiniDeps.add('folke/tokyonight.nvim')
    require('tokyonight').setup({
        styles = {
            keywords = { italic = false },
            floats = 'normal',
        },
    })
    vim.cmd('colorscheme tokyonight-night')
end)
