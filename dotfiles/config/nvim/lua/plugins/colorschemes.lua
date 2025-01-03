return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = true,
    init = function()
      -- vim.cmd([[colorscheme tokyonight-moon]])
      -- vim.cmd([[colorscheme tokyonight-night]])
      -- vim.cmd([[colorscheme tokyonight-storm]])
      -- vim.cmd([[colorscheme tokyonight-day]])
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = {
      dimInactive = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    },
    init = function()
      -- vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    init = function()
      -- vim.cmd.colorscheme("lackluster")
      -- vim.cmd.colorscheme("lackluster-hack")
      -- vim.cmd.colorscheme("lackluster-mint")
    end,
  },
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
      },
    },
    init = function()
      vim.cmd([[colorscheme rose-pine-moon]])
    end,
  },
  {
    init = function()
      -- vim.cmd([[colorscheme catppuccin-latte]])
      -- vim.cmd([[colorscheme catppuccin-frappe]])
      -- vim.cmd([[colorscheme catppuccin-mocha]])
      -- vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      transparent_background = false,
      no_italic = true,
      integrations = {
        noice = true,
        mason = true,
        harpoon = true,
        notify = true,
        neotree = true,
        navic = true,
        treesitter_context = true,
        which_key = true,
        lsp_trouble = true,
        flash = true,
        indent_blankline = {
          enabled = true,
          scope_color = '',
          color_indent_levels = false,
        },
        cmp = true,
        dashboard = true,
        gitsigns = true,
        illuminate = {
          enabled = true,
        },
        mini = {
          enabled = true,
          indentscope_color = 'overlay0',
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        treesitter = true,
      },
    },
  },
}
