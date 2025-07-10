MiniDeps.now(function()
    MiniDeps.add('rose-pine/neovim')
    require('rose-pine').setup({
        styles = {
            bold = false,
            italic = true,
        },
        dim_inactive_windows = false,
        highlight_groups = {
            FloatBorder = { bg = 'base' },
            FloatTitle = { bg = 'base' },
            FloatFooter = { bg = 'base' },
            NormalFloat = { bg = 'base' },
            StatusLine = { bg = 'base' },
            StatusLineNC = { bg = 'base' },
            -- Mini
            MiniFilesTitleFocused = { bg = 'base' },
            MiniClueTitle = { bg = 'base' },
            MiniPickPrompt = { bg = 'base', fg = 'foam' },
            MiniPickBorderText = { bg = 'base' },
            MiniPickMatchRanges = { fg = 'rose' },
        },
    })
    vim.cmd('colorscheme rose-pine')
end)
