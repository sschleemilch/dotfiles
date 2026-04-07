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

Config.new_autocmd('LspProgress', nil, function(ev)
    local value = ev.data.params.value or {}
    local msg = value.message or 'done'

    if #msg > 40 then
        msg = msg:sub(1, 37) .. '...'
    end

    vim.api.nvim_echo({ { msg } }, false, {
        id = 'lsp.' .. ev.data.client_id,
        source = 'vim.lsp',
        kind = 'progress',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percent,
    })
end)
