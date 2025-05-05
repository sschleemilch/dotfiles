return {
  'MagicDuck/grug-far.nvim',
  opts = {},
  cmd = 'GrugFar',
  keys = {
    {
      '<leader>sr',
      '<cmd>GrugFar<cr>',
      desc = 'Replace in files (Grug-far)',
      mode = { 'n', 'v' },
    },
  },
}
