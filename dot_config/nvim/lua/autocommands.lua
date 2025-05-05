_G.augroup = function(name)
  return vim.api.nvim_create_augroup('sschleemilch/' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  desc = 'Go to the last location when opening a buffer',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'grug-far',
    'help',
    'lspinfo',
    'qf',
    'checkhealth',
    'gitsigns.blame',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = 'Quit buffer',
    })
  end,
})

local line_numbers_group = vim.api.nvim_create_augroup('sschleemilch/toggle_line_numbers', {})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  group = line_numbers_group,
  desc = 'Toggle relative line numbers on',
  callback = function()
    if vim.wo.nu and not vim.startswith(vim.api.nvim_get_mode().mode, 'i') then
      vim.wo.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  group = line_numbers_group,
  desc = 'Toggle relative line numbers off',
  callback = function(args)
    if vim.wo.nu then
      vim.wo.relativenumber = false
    end

    -- Redraw here to avoid having to first write something for the line numbers to update.
    if args.event == 'CmdlineEnter' then
      if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
        vim.cmd.redraw()
      end
    end
  end,
})
