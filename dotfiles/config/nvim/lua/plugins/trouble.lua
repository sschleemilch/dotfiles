return {
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      focus = true,
      auto_close = true,
    },
    keys = {
      { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    },
  },
}
