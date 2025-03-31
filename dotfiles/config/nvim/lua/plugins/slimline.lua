return {
  {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    lazy = false,
    -- dev = true,
    opts = {
      style = 'fg',
      configs = {
        mode = {
          style = 'bg',
          verbose = true,
        },
        diagnostics = {
          workspace = false,
        },
      },
    },
  },
}
