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
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    enabled = true,
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
    -- 'slimline',
    dev = false,
    opts = {
      style = 'fg',
      mode_follow_style = true,
      verbose_mode = false,
      spaces = {
        components = '',
        left = '',
        right = '',
      },
      hl = {
        primary = 'Comment',
      },
      sep = {
        hide = {
          first = true,
          last = true,
        },
        left = '',
        right = '',
      },
    },
  },
  {
    'SmiteshP/nvim-navic',
    opts = {
      depth_limit = 6,
      highlight = true,
    },
  },
}
