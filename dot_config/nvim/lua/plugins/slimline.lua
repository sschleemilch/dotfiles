return {
  'sschleemilch/slimline.nvim',
  -- 'slimline.nvim',
  event = 'VeryLazy',
  -- dev = true,
  opts = {
    bold = true,
    style = 'bg',
    components = {
      left = {
        'mode',
        'git',
      },
    },
    configs = {
      mode = {
        verbose = true,
      },
      diagnostics = {
        workspace = true,
        style = 'fg',
      },
      progress = {
        column = true,
        follow = false,
      },
    },

    sep = {
      left = '',
      right = '',
      hide = {
        first = true,
        last = true,
      },
    },

    hl = {
      primary = 'NormalFloat',
    },

    spaces = {
      left = '',
      right = '',
      components = '',
    },
  },
}
