return {
  'MagicDuck/grug-far.nvim',
  opts = {
    headerMaxWidth = 80,
  },
  cmd = 'GrugFar',
  mode = { 'n', 'v' },
  keys = {
    {
      '<leader>sr',
      '<cmd>GrugFar<cr>',
      desc = 'Replace in files (Grug-far)',
    },
  },
}
