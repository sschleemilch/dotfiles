return {
  {
    'sschleemilch/slimline.nvim',
    -- 'slimline.nvim',
    lazy = false,
    -- dev = true,
    opts = {
      bold = true,
      style = 'fg',
      components = {
        left = {
          'mode',
          'git'
        }
      },
      configs = {
        mode = {
          verbose = true,
        },
        diagnostics = {
          workspace = true,
        },
        progress = {
          column = true,
        }
      },
    },
  },
}
