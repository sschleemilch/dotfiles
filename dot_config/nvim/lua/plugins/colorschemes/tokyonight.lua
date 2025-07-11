MiniDeps.now(function()
    MiniDeps.add('folke/tokyonight.nvim')
    require('tokyonight').setup({
        styles = {
            keywords = { italic = false },
            floats = 'normal',
        },
        on_colors = function() end,
        on_highlights = function(hl, c)
            hl.StatusLine = { bg = c.bg }
            hl.StatusLineNC = { bg = c.bg }
        end,
    })
    vim.cmd('colorscheme tokyonight-night')
end)
