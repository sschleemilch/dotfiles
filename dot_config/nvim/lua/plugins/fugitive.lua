return {
  'tpope/vim-fugitive',
  lazy = false,
  keys = {
    {
      '<leader>gs',
      '<cmd>Git<cr>',
      desc = 'Git status',
    },
    {
      'gh',
      '<cmd>diffget //2<cr>',
      desc = 'Diffget from Fugitive left',
    },
    {
      'gl',
      '<cmd>diffget //3<cr>',
      desc = 'Diffget from Fugitive right',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = augroup('fugitive'),
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', '<leader>P', function()
          vim.cmd.Git('push')
        end, opts)

        vim.keymap.set('n', '<leader>p', function()
          vim.cmd.Git('pull --rebase')
        end, opts)
      end,
    })
  end,
}
