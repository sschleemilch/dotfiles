MiniDeps.now(function()
    MiniDeps.add('catppuccin/nvim')
    require('catppuccin').setup({})
    vim.cmd('colorscheme catppuccin-mocha')
end)
