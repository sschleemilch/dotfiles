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
      style = 'fg',
      bold = true,
      mode_follow_style = false,
      verbose_mode = true,
      workspace_diagnostics = true,
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
}
