return {
  'folke/flash.nvim',
  opts = {
    prompt = {
      enabled = false,
    },
  },
  event = 'VeryLazy',
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
  },
}
