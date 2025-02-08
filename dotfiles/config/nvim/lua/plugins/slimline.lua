return {
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
