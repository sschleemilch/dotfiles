return {
  {
    'echasnovski/mini.icons',
    enabled = true,
    lazy = false,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'echasnovski/mini.indentscope',
    enabled = false,
    lazy = false,
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    enabled = false,
    opts = {
      indent = {
        char = '╎',
        tab_char = '╎',
        -- tab_char = '│',
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'fzf',
          'help',
          'lazy',
          'mason',
        },
      },
    },
    main = 'ibl',
  },
  {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    lazy = false,
    dev = false,
    opts = {
      style = 'fg',
      bold = true,
      mode_follow_style = true,
      verbose_mode = true,
      spaces = {
        components = '',
        left = '',
        right = '',
      },
      components = {
        left = {
          'mode',
          'git',
        },
      },
      sep = {
        hide = {
          first = true,
          last = true,
        },
        left = '',
        right = '',
      },
    },
  },
}
