return {
  'echasnovski/mini.files',
  version = false,
  lazy = false,
  opts = {},
  keys = {
    {
      '<leader>e',
      function()
        local minifiles = require('mini.files')
        minifiles.open(vim.api.nvim_buf_get_name(0))
        minifiles.reveal_cwd()
      end,
      desc = 'Explorer',
    },
  },
}
