local function map(mode, lhs, rhs, opts)
  opts = opts or { silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Reselect latest changed, put, or yanked text
map(
  'n',
  'gV',
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = 'Visually select changed text' }
)

-- Window navigation
map('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
map('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
map('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
map('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
_G.close_other_buffers = function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end
map('n', '<leader>bo', ':lua close_other_buffers()<CR>', { desc = 'Close Other Buffers' })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- Make U opposite to u.
map('n', 'U', '<C-r>', { desc = 'Redo' })

-- Keeping the cursor centered.
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
map('n', 'n', 'nzzzv', { desc = 'Next result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- save file
-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map('n', '<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' })
map({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
