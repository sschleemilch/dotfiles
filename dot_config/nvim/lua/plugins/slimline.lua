return {
  'sschleemilch/slimline.nvim',
  -- 'slimline.nvim',
  lazy = false,
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

    spaces = {
      left = '',
      right = '',
      components = '',
    },

    hl = {
      primary = 'BufferVisible',
      secondary = 'BufferInactiveSign',
    },
  },
}
