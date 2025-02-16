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
        -- Plugin specific
        BlinkCmpKindFunction = { fg = 'rose' },
        BlinkCmpKindMethod = { fg = 'rose' },
        BlinkCmpKindVariable = { fg = 'iris' },
        BlinkCmpKindKeyword = { fg = 'pine' },
        BlinkCmpKindText = { fg = 'text' },
        BlinkCmpKindConstant = { fg = 'gold' },
        BlinkCmpSignatureHelpBorder = { fg = 'muted' },
        MiniFilesTitleFocused = { bg = 'base' },
        SnacksIndentChunk = { fg = 'subtle' },
        SnacksIndentScope = { fg = 'subtle' },
      },
    },

    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
}
