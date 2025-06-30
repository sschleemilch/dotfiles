return {
    {
        'rose-pine/neovim',
        lazy = false,
        priority = 1000,
        name = 'rose-pine',
        opts = {
            dim_inactive_windows = false,
            highlight_groups = {
                -- General
                FloatBorder = { bg = 'base' },
                FloatTitle = { bg = 'base' },
                FloatFooter = { bg = 'base' },
                NormalFloat = { bg = 'base' },
                StatusLine = { bg = 'base' },

                Pmenu = { bg = 'base', fg = 'muted' },

                -- Mini
                MiniFilesTitleFocused = { bg = 'base' },
                MiniClueTitle = { bg = 'base' },
            },
        },

        init = function()
            vim.cmd('colorscheme rose-pine')
        end,
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        enabled = false,
        opts = {
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
                local makeDiagnosticColor = function(color)
                    local c = require('kanagawa.lib.color')
                    return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                end
                return {
                    FloatBorder = { bg = theme.ui.bg },
                    FloatTitle = { bg = theme.ui.bg },
                    FloatFooter = { bg = theme.ui.bg },
                    NormalFloat = { bg = theme.ui.bg },
                    CursorLine = { bg = theme.ui.bg_p1 },
                    CursorLineNC = { bg = theme.ui.bg_p1 },

                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
                    PmenuSel = { fg = 'NONE', bg = theme.ui.bg_visual },
                    PmenuThumb = { bg = theme.ui.float.fg_border },

                    -- Blink
                    BlinkCmpMenuBorder = { bg = theme.ui.bg, fg = theme.ui.float.fg_border },
                    -- Mini
                    MiniFilesTitleFocused = { bg = theme.ui.bg },
                    MiniFilesTitle = { bg = theme.ui.bg },
                    MiniClueTitle = { bg = theme.ui.bg },

                    -- Diagnostics
                    DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
                    DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
                    DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
                    DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
                }
            end,
        },
        init = function()
            vim.cmd('colorscheme kanagawa')
        end,
    },
}
