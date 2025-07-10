MiniDeps.now(function()
    MiniDeps.add('rebelot/kanagawa.nvim')
    require('kanagawa').setup({
        undercurl = false,
        keywordStyle = { italic = false },
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = 'none',
                    },
                },
            },
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                FloatBorder = { bg = theme.ui.bg },
                FloatTitle = { bg = theme.ui.bg },
                FloatFooter = { bg = theme.ui.bg },
                NormalFloat = { bg = theme.ui.bg },
                StatusLine = { bg = theme.ui.bg },
                StatusLineNC = { bg = theme.ui.bg },
                -- Mini
                MiniFilesTitleFocused = { bg = theme.ui.bg },
                MiniFilesTitle = { bg = theme.ui.bg },
                MiniPickPrompt = { bg = theme.ui.bg },
                MiniPickBorderText = { bg = theme.ui.bg },
            }
        end,
    })
    vim.cmd('colorscheme kanagawa')
end)
