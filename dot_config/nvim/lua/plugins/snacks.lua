MiniDeps.now(function()
  MiniDeps.add('folke/snacks.nvim')
  require('snacks').setup({
    input = {},
    indent = {
      indent = {
        char = '╎',
      },
      scope = {
        char = '╎',
      },
    },
    styles = {
      input = {
        border = 'single',
      },
    },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  })
  vim.keymap.set('n', '<leader>bd', function()
    Snacks.bufdelete()
  end, { desc = 'Delete buffer' })
end)

MiniDeps.later(function()
  Snacks.toggle.diagnostics():map('<leader>td')
  Snacks.toggle.indent():map('<leader>ti')
  Snacks.toggle.words():map('<leader>tw')
  Snacks.toggle.dim():map('<leader>tD')
end)
