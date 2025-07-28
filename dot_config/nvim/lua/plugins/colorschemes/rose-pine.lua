MiniDeps.now(function()
    MiniDeps.add('rose-pine/neovim')
    require('rose-pine').setup({
        styles = {
            bold = false,
            italic = false,
        },
        dim_inactive_windows = false,
    })
    vim.cmd('colorscheme rose-pine')
end)
