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
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    lazy = false,
    dev = false,
    opts = {
      style = 'bg',
      bold = true,
      mode_follow_style = true,
      verbose_mode = true,
      spaces = {
        --   components = '',
        -- left = '',
        -- right = '',
      },
      components = {
        left = {
          'mode',
          'git',
          'recording',
        },
      },
      sep = {
        hide = {
          first = false,
          last = false,
        },
        right = '',
        left = '',
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = {
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'lsp',
            kind = 'progress',
            cond = function(message)
              local client = vim.tbl_get(message.opts, 'progress', 'client')
              return client == 'ltex'
            end,
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
        },
        popupmenu = {
          relative = 'editor',
          position = {
            row = 8,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
    },
  },
}
