return {
    'echasnovski/mini.notify',
    opts = function()
        local ignore = {
            'ltex_plus',
        }
        return {
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
                    border = 'none',
                },
            },
        }
    end,
    init = function()
        vim.notify = require('mini.notify').make_notify()
    end,
    keys = {
        {
            '<leader>nh',
            function()
                MiniNotify.show_history()
            end,
            desc = 'Notification history',
        },
        {
            '<leader>nc',
            function()
                MiniNotify.clear()
            end,
            desc = 'Clear notifications',
        },
    },
}
