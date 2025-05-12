return {
  'rose-pine/neovim',
  lazy = false,
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

      WinBar = { fg = 'text', bg = 'base' },
      WinBarNC = { bg = 'base' },
      WinBarSeparator = { fg = 'subtle' },

      Pmenu = { bg = 'base', fg = 'muted' },

      -- Snacks
      SnacksIndentChunk = { fg = 'subtle' },
      SnacksIndentScope = { fg = 'subtle' },

      -- Mini
      MiniFilesTitleFocused = { bg = 'base' },
      MiniClueTitle = { bg = 'base' },
    },
  },

  config = function(_, opts)
    require('rose-pine').setup(opts)
    vim.cmd([[colorscheme rose-pine-moon]])
  end,
}
