return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
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
}
