MiniDeps.now(function()
    MiniDeps.add('folke/tokyonight.nvim')
    require('tokyonight').setup({
        styles = {
            keywords = { italic = false },
        },
        on_colors = function() end,
        on_highlights = function(hl, c)
            hl.FloatBorder = { bg = c.bg, fg = hl.FloatBorder.fg }
            hl.FloatTitle = { bg = c.bg, fg = hl.FloatTitle.fg }
            hl.NormalFloat = { bg = c.bg, fg = hl.NormalFloat.fg }
            hl.StatusLine = { bg = c.bg }
            hl.StatusLineNC = { bg = c.bg }
            -- Mini
            hl.MiniFilesTitleFocused = { bg = c.bg, fg = hl.MiniFilesTitleFocused.fg }
            hl.MiniClueTitle = { bg = c.bg, fg = hl.MiniClueTitle.fg }
            hl.MiniPickPrompt = { bg = c.bg, fg = hl.MiniPickPrompt.fg }
            hl.MiniPickBorderText = { bg = c.bg, fg = hl.MiniPickBorderText.fg }
        end,
    })
    vim.cmd('colorscheme tokyonight-night')
end)
