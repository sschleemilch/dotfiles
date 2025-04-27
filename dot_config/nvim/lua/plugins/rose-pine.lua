return {
  {
    'rose-pine/neovim',
    lazy = false,
    enabled = true,
    priority = 1000,
    name = 'rose-pine',
    opts = {
      dim_inactive_windows = false,
      highlight_groups = {
        -- General
        CursorLine = { bg = 'surface' },
        FloatBorder = { bg = 'base' },
        FloatTitle = { bg = 'base' },
        FloatFooter = { bg = 'base' },
        NormalFloat = { bg = 'base' },
        StatusLine = { bg = 'base' },
        Pmenu = { bg = 'base', fg = 'muted' },

        -- Blink
        BlinkCmpKindFunction = { fg = 'rose' },
        BlinkCmpKindMethod = { fg = 'rose' },
        BlinkCmpKindVariable = { fg = 'iris' },
        BlinkCmpKindKeyword = { fg = 'pine' },
        BlinkCmpKindText = { fg = 'text' },
        BlinkCmpKindConstant = { fg = 'gold' },
        BlinkCmpSignatureHelpBorder = { fg = 'muted' },

        -- Snacks
        SnacksIndentChunk = { fg = 'subtle' },
        SnacksIndentScope = { fg = 'subtle' },

        -- Mini
        MiniFilesTitleFocused = { bg = 'base' },
        MiniClueTitle = { bg = 'base' },
        MiniTablineFill = { bg = 'base' },
        MiniTablineHidden = { bg = 'base', fg = 'subtle' },
        MiniTablineCurrent = { bg = 'base', fg = 'text' },
        MiniTablineVisible = { bg = 'base', fg = 'text' },
        MiniTablineModifiedCurrent = { bg = 'base', fg = 'text' },
        MiniTablineModifiedHidden = { bg = 'base', fg = 'subtle' },
        MiniTablineModifiedVisible = { bg = 'base', fg = 'text' },
      },
    },

    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd([[colorscheme rose-pine-moon]])
    end,
  },
}
