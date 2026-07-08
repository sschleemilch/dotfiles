-- Highlight on yank
Config.new_autocmd('TextYankPost', nil, function()
    vim.hl.on_yank({ timeout = 150 })
end, 'Highlight on yank')
