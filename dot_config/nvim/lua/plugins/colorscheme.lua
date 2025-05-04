MiniDeps.now(function()
  MiniDeps.add('rose-pine/neovim')
  require('rose-pine').setup({
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
      MiniTablineHidden = { bg = 'overlay', fg = 'subtle' },
      MiniTablineCurrent = { bg = 'subtle', fg = 'base' },
      MiniTablineVisible = { bg = 'overlay', fg = 'subtle' },
      MiniTablineModifiedCurrent = { bg = 'subtle', fg = 'base' },
      MiniTablineModifiedHidden = { bg = 'overlay', fg = 'subtle' },
      MiniTablineModifiedVisible = { bg = 'overlay', fg = 'subtle' },
    },
  })
  vim.cmd('colorscheme rose-pine-moon')
end)
