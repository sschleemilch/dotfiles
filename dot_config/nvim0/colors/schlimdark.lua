local c = {
    NvimDarkGray1 = '#07080d',
    NvimDarkGray2 = '#14161b',
    NvimDarkGray3 = '#2c2e33',
    NvimDarkGray4 = '#4f5258',
    NvimLightBlue = '#a6dbff',
    NvimLightCyan = '#8cf8f7',
    NvimLightGray1 = '#eef1f8',
    NvimLightGray2 = '#e0e2ea',
    NvimLightGray3 = '#c4c6cd',
    NvimLightGray4 = '#9b9ea4',
    NvimLightGreen = '#b3f6c0',
    NvimLightMagenta = '#ffcaff',
    NvimLightRed = '#ffc0b9',
    NvimLightYellow = '#fce094',
    NvimDarkYellow = '#6b5300',
    NvimDarkBlue = '#004c73',
    NvimDarkCyan = '#007373',
    NvimDarkMagenta = '#470045',
    NvimDarkRed = '#590008',
}

local groups = {
    -- Quite some noise for e.g. lua
    Identifier = { fg = c.NvimLightGray2, update = true },
    Operator = { fg = c.NvimLightGray4 },
    Delimiter = { link = 'Operator' },

    NormalFloat = { link = 'Normal' },
    FloatBorder = { link = 'Comment' },
    FloatTitle = { bg = 'NONE', update = true },
    Pmenu = { bg = 'NONE', update = true },
    DiffAdd = { fg = c.NvimLightGreen },
    DiffChange = { fg = c.NvimLightYellow },

    -- PLUGINS
    MiniPickPrompt = { link = 'Normal' },
    MiniClueSeparator = { link = 'Comment' },
    TreesitterContext = { link = 'Folded' },
}

for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
end
