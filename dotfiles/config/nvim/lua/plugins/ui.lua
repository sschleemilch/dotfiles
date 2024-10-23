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
    'echasnovski/mini.notify',
    enabled = true,
    version = false,
    config = {
      window = {
        config = {
          border = 'none',
        },
      },
    },
    init = function()
      vim.notify = require('mini.notify').make_notify()
    end,
    keys = {
      {
        '<leader>nh',
        function()
          require('mini.notify').show_history()
        end,
        desc = 'Notification history',
      },
    },
  },
  {
    'sschleemilch/slimline.nvim',
    -- 'slimline',
    dev = false,
    opts = {
      style = 'fg',
      mode_follow_style = false,
      -- spaces = {
      --   components = '',
      --   left = '',
      --   right = '',
      -- },
      -- sep = {
      --   hide = {
      --     first = true,
      --     last = true,
      --   },
      --   left = '',
      --   right = '',
      -- },
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
