return {
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
        'git',
        function()
          return require('nvim-navic').get_location()
        end,
      },
    },
    configs = {
      mode = {
        style = 'bg',
        verbose = false,
      },
      diagnostics = {
        workspace = true,
      },
      progress = {
        column = true,
        follow = false,
      },
    },
  },
}
