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

        -- Trouble
        TroubleNormal = { bg = 'base' },
        TroubleNormalNC = { bg = 'base' },

        -- Mini
        MiniFilesTitleFocused = { bg = 'base' },
        MiniClueTitle = { bg = 'base' }
      },
    },

    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd([[colorscheme rose-pine-moon]])
    end,
  },
}
