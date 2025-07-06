MiniDeps.now(function()
    local ignore = {
        'ltex_plus',
    }
    require('mini.notify').setup({
        content = {
            format = function(notif)
                if vim.tbl_contains(ignore, notif.data.client_name) then
                    return ''
                end
                return ' ' .. notif.msg .. ' '
            end,
        },
        window = {
            config = {
                title = '',
            },
        },
    })
    vim.notify = MiniNotify.make_notify()

    vim.keymap.set('n', '<leader>nh', function()
        MiniNotify.show_history()
    end, { desc = 'Notification history' })
end)
