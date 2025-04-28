return {
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

      WinBar = { bg = 'base' },
      WinBarNC = { bg = 'base' },

      Pmenu = { bg = 'base', fg = 'muted' },

      -- Snacks
      SnacksIndentChunk = { fg = 'subtle' },
      SnacksIndentScope = { fg = 'subtle' },

      -- Mini
      MiniFilesTitleFocused = { bg = 'base' },
      MiniClueTitle = { bg = 'base' },
      MiniTablineFill = { bg = 'base' },
      MiniTablineHidden = { bg = 'base', fg = 'subtle' },
      MiniTablineCurrent = { bg = 'base', fg = 'text' },
      MiniTablineVisible = { bg = 'base', fg = 'subtle' },
      MiniTablineModifiedCurrent = { bg = 'base', fg = 'text' },
      MiniTablineModifiedHidden = { bg = 'base', fg = 'subtle' },
      MiniTablineModifiedVisible = { bg = 'base', fg = 'subtle' },
    },
  },

  config = function(_, opts)
    require('rose-pine').setup(opts)
    vim.cmd([[colorscheme rose-pine-moon]])
  end,
}
