MiniDeps.now(function()
    MiniDeps.add('folke/tokyonight.nvim')
    require('tokyonight').setup({
        styles = {
            keywords = { italic = false },
        },
    })
    vim.cmd('colorscheme tokyonight-night')
end)
