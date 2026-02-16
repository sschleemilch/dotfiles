-- Highlight on yank
Config.new_autocmd('TextYankPost', nil, function()
    vim.hl.on_yank()
end, 'Highlight on yank')

-- go to last loc when opening a buffer
Config.new_autocmd('BufReadPost', nil, function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
        vim.cmd('normal! g`"zz')
    end
end, 'Go to the last location when opening a buffer')
