_G.augroup = function(name)
    return vim.api.nvim_create_augroup('sschleemilch/' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.hl.on_yank()
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
