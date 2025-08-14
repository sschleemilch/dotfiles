local function map(mode, lhs, rhs, opts)
    opts = opts or { silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Move lines
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Clear search highlight
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- Keeping the cursor centered.
map('n', 'n', 'nzzzv', { desc = 'Next result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Run command and put result into scratch buffer
map('n', '<space>c', function()
    vim.ui.input({}, function(c)
        if c and c ~= '' then
            vim.cmd('noswapfile vnew')
            vim.bo.buftype = 'nofile'
            vim.bo.bufhidden = 'wipe'
            vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
        end
    end)
end)
